import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

  @override
  State<UserImagePicker> createState() {
    return _UserImagePickerState();
  }
}

class _UserImagePickerState extends State<UserImagePicker> {
  @override
  void initState() {
    super.initState();
    _initImage();
  }

  final ImagePicker _imagePicker = ImagePicker();
  File? _imageFile;
  late String _imageUrl;

  Future<void> _initImage() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser!;
      final userId = currentUser.uid;
      final firestore = FirebaseFirestore.instance;
      final storage = FirebaseStorage.instance;

      final userData = await firestore.collection('users').doc(userId).get();
      final imageUrl = userData.data()?['image_url'];

      if (imageUrl != null) {
        final ref = storage.refFromURL(imageUrl);
        final tempFile = File((await ref.getDownloadURL()));
        setState(() {
          _imageFile = tempFile;
          _imageUrl = imageUrl;
        });
      }
    } catch (e) {
      print('Si è verificato un errore durante il recupero dell\'immagine: $e');
    }
  }

  Future<void> _getImage() async {
    final pickedImage = (await _imagePicker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front));

    if (pickedImage != null) {
      _imageFile = File(pickedImage.path);

      final currentUser = FirebaseAuth.instance.currentUser!;

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${currentUser.uid}.jpg');

      await storageRef.putFile(_imageFile!);
      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update({
        'image_url': imageUrl,
      });

      setState(() {
        _imageUrl = imageUrl;
      });
    }
  }

  Future<void> _removeImage() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final userId = currentUser.uid;
    final firestore = FirebaseFirestore.instance;
    final storage = FirebaseStorage.instance;

    final userData = await firestore.collection('users').doc(userId).get();
    final imageUrl = userData.data()?['image_url'];

    if (_imageFile != null) {
      final storageRef = storage.refFromURL(imageUrl);
      await storageRef.delete();

      await firestore.collection('users').doc(userId).update({
        'image_url': FieldValue.delete(),
      });
      setState(() {
        _imageFile = null;
        _imageUrl = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: _imageFile != null && _imageFile!.path.isNotEmpty
              ? Colors.transparent
              : const Color(0xFF005BBE),
          child: _imageFile != null && _imageFile!.path.isNotEmpty
              ? ClipOval(
                  child: Image.network(
                    _imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                )
              : const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
        ),
        _imageFile == null
            ? TextButton.icon(
                onPressed: _getImage,
                icon: const Icon(Icons.image),
                label: Text(
                  'Add Image',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ))
            : TextButton.icon(
                onPressed: _removeImage,
                icon: const Icon(Icons.image),
                label: Text(
                  'Remove Image',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
      ],
    );
  }
}
