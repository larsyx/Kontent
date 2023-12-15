import 'package:flutter/material.dart';
import 'package:kontent/kontentPages/kontent_forgotten_password_.dart';
import 'package:kontent/kontentWidgets/kontent_button.dart';
import 'kontent_registration_page.dart';
import '../main.dart';

class KontentLoginPageWidget extends StatefulWidget {
  const KontentLoginPageWidget({
    super.key,
  });

  @override
  State<KontentLoginPageWidget> createState() => _KontentLoginPageState();
}

class _KontentLoginPageState extends State<KontentLoginPageWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isObscure = true;

  void submitForm() {
    // Invia i dati al server
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const KontentMainWidget(title: 'Kontent')));
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
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Image(
                      image: AssetImage(
                          'assets/images/TransparentLogoKontent.png')),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Password',
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
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const KontentForgottenPasswordPageWidget()));
                      //TODO
                    },
                    child: const Text(
                      'Password dimenticata?',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  KontentButton(onPressed: submitForm, text: 'Accedi'),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Sei nuovo?'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const KontentRegistrationPageWidget()));
                          },
                          child: const Text(
                            'Registrati ora',
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
          ),
        ));
  }
}
