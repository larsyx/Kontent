import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kontent/entities/carousel.dart';
import 'package:kontent/entities/content.dart';
import 'package:kontent/kontentWidgets/kontent_carousel.dart';
import 'package:kontent/kontentWidgets/kontent_change_password_dialog.dart';
import 'package:image_picker/image_picker.dart';

class KontentAccountPageBodyWidget extends StatefulWidget {
  const KontentAccountPageBodyWidget({super.key});

  @override
  _KontentAccountPageBodyWidgetState createState() =>
      _KontentAccountPageBodyWidgetState();
}

class _KontentAccountPageBodyWidgetState
    extends State<KontentAccountPageBodyWidget> {
  ImagePicker _imagePicker = ImagePicker();
  XFile? _imageFile;
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    getEmail();
    _imagePicker = ImagePicker();
  }

  Future<void> _getImage() async {
    final XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);

    if (pickedImage != null) {
      setState(() {
        _imageFile = pickedImage;
      });
    }
  }

  void _removeImage() {
    setState(() {
      _imageFile = null;
    });
  }

  Future<void> getEmail() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        userEmail = user.email ?? 'Nessuna email disponibile';
      });
    } else {
      setState(() {
        userEmail = 'L\'utente non è autenticato';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 25),
            Stack(
              children: [
                GestureDetector(
                  onTap: _getImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor:
                        _imageFile != null && _imageFile!.path.isNotEmpty
                            ? Colors.transparent
                            : const Color(0xFF005BBE),
                    child: _imageFile != null && _imageFile!.path.isNotEmpty
                        ? ClipOval(
                            child: Image.file(
                              File(_imageFile!.path),
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                  ),
                ),
                if (_imageFile != null && _imageFile!.path.isNotEmpty)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _removeImage,
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xFF005BBE),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name Surname',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "example@example.it",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                dialogChangePassword(context);
              },
              child: const Text('Change Password'),
            ),
            const SizedBox(height: 20),
            KontentCarouselWrapper(
              carousel: Carousel(
                  id: '',
                  title: 'Recently viewed',
                  type: '',
                  orientation: KontentCarouselType.vertical,
                  items: List<Content>.empty()),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Implement logout features
                FirebaseAuth.instance.signOut();
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
