import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kontent/entities/carousel.dart';
import 'package:kontent/entities/content.dart';
import 'package:kontent/kontentWidgets/kontent_carousel.dart';
import 'package:kontent/kontentWidgets/kontent_change_password_dialog.dart';
import 'package:kontent/kontentWidgets/kontent_user_image.dart';

class KontentAccountPageBodyWidget extends StatefulWidget {
  const KontentAccountPageBodyWidget({super.key});

  @override
  State<KontentAccountPageBodyWidget> createState() =>
      _KontentAccountPageBodyWidgetState();
}

class _KontentAccountPageBodyWidgetState
    extends State<KontentAccountPageBodyWidget> {
  String _userUsername = '';
  String _userEmail = '';

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final userId = currentUser.uid;
    final firestore = FirebaseFirestore.instance;

    final userData = await firestore.collection('users').doc(userId).get();
    final username = userData.data()?['username'];
    final email = userData.data()?['email'];

    if (username != null) {
      setState(() {
        _userUsername = username;
        _userEmail = email;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.of(context).orientation == Orientation.portrait
          ? _buildPortraitLayout()
          : _buildLandscapeLayout(),
    );
  }

  Widget _buildPortraitLayout() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 15),
            const UserImagePicker(),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _userUsername,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  _userEmail,
                  style: const TextStyle(
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
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text("Logout"),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _buildLandscapeLayout() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 15),
            const UserImagePicker(),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _userUsername,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  _userEmail,
                  style: const TextStyle(
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
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Text("Logout"),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
