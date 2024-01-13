import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kontent/kontentWidgets/kontent_button.dart';

class KontentForgottenPasswordPageWidget extends StatefulWidget {
  const KontentForgottenPasswordPageWidget({super.key});

  @override
  State<KontentForgottenPasswordPageWidget> createState() =>
      _KontentForgottenPasswordState();
}

class _KontentForgottenPasswordState
    extends State<KontentForgottenPasswordPageWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void submitForm() {
    // Invia i dati al server
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("kontent"),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          titleTextStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ),
            KontentButton(onPressed: submitForm, text: "Reset"),
          ],
        ));
  }
}
