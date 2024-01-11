import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  var isObscure1 = true;
  var isObscure2 = true;
  var isObscure3 = true;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    final currentUser = _auth.currentUser!;

    final String oldPassword = _oldPasswordController.text;
    final String newPassword = _newPasswordController.text;

    // Reautenticazione per confermare l'identità dell'utente
    AuthCredential credential = EmailAuthProvider.credential(
      email: currentUser.email!,
      password: oldPassword,
    );

    await currentUser.reauthenticateWithCredential(credential);
    await currentUser.updatePassword(newPassword);

    // Mostra un messaggio di successo
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Password cambiata con successo'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _oldPasswordController,
                validator: validateOldPassword,
                decoration: InputDecoration(
                  labelText: 'Old Password',
                  suffixIcon: IconButton(
                      icon: Icon(
                        isObscure1 ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isObscure1 = !isObscure1;
                        });
                      }),
                ),
                obscureText: isObscure1,
              ),
              TextFormField(
                controller: _newPasswordController,
                validator: validateNewPassword,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  suffixIcon: IconButton(
                      icon: Icon(
                        isObscure2 ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isObscure2 = !isObscure2;
                        });
                      }),
                ),
                obscureText: isObscure2,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  suffixIcon: IconButton(
                      icon: Icon(
                        isObscure3 ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isObscure3 = !isObscure3;
                        });
                      }),
                ),
                obscureText: isObscure3,
                validator: validateConfirmPassword,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            _changePassword(context);
          },
          child: const Text('Change Password'),
        ),
      ],
    );
  }

  String? validateOldPassword(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password: \n'
            '- 1 uppercase letter \n'
            '- 1 lowercase letter \n'
            '- 1 number \n'
            '- 1 special character !@\$&*~. \n'
            '- Minimum length: 8 characters';
      } else {
        return null;
      }
    }
  }

  String? validateNewPassword(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password: \n'
            '- 1 uppercase letter \n'
            '- 1 lowercase letter \n'
            '- 1 number \n'
            '- 1 special character !@\$&*~. \n'
            '- Minimum length: 8 characters';
      } else if (value == _oldPasswordController.text) {
        return 'The new password coincides \nwith the previous one.';
      } else {
        return null;
      }
    }
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password';
    } else {
      if (_newPasswordController.text != value) {
        return 'Le password non coincidono';
      } else {
        return null;
      }
    }
  }
}

Future<dynamic> dialogChangePassword(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return const ChangePasswordDialog();
    },
  );
}
