import 'package:flutter/material.dart';

class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          const Text('Changing'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Old Password'),
              obscureText: true,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Change Password'),
        ),
      ],
    );
  }
}

Future<dynamic> dialogChangePassword(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return ChangePasswordDialog(context);
    },
  );
}