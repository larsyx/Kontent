import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:kontent/kontentWidgets/kontent_button.dart';

class KontentRegistrationPageWidget extends StatefulWidget {
  const KontentRegistrationPageWidget({super.key});

  @override
  State<StatefulWidget> createState() => __KontentRegistrationPageState();
}

class __KontentRegistrationPageState
    extends State<KontentRegistrationPageWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  var isObscure = true;

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'inserisci una username';
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'inserisci l\'email';
    } else if (!EmailValidator.validate(value)) {
      return 'inserisci una email valida';
    }
    return null;
  }

  String? validatePassword(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Conferma la password';
    } else {
      if (_passwordController.text != value) {
        return 'Le password non coincidono';
      } else {
        return null;
      }
    }
  }

  void submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Invia i dati al server
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Kontent"),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          titleTextStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'Registrazione',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                          validator: validateUsername,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmail,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                }),
                          ),
                          validator: validatePassword,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isObscure,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                }),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isObscure,
                          validator: validateConfirmPassword,
                        ),
                      ),
                      KontentButton(onPressed: submitForm, text: "Registrati")
                    ],
                  ),
                ),
              ]),
            )));
  }
}
