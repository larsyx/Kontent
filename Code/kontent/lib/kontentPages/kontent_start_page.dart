import 'package:flutter/material.dart';
import 'package:kontent/kontentPages/kontent_login_page.dart';
import 'package:kontent/kontentPages/kontent_registration_page.dart';
import 'package:kontent/kontentWidgets/kontent_button.dart';

class KontentStartPageWidget extends StatelessWidget {
  const KontentStartPageWidget({super.key});

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(20),
            child: Image(
                image: AssetImage('assets/images/TransparentLogoKontent.png')),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: KontentButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const KontentLoginPageWidget()));
                },
                text: "Accedi"),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: KontentButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const KontentRegistrationPageWidget()));
                },
                text: "Registrati"),
          ),
        ],
      ),
    );
  }
}
