// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class KontentStartPage extends StatefulWidget {
//   @override
//   _KontentStartPageState createState() => _KontentStartPageState();
// }

// class _KontentStartPageState extends State<KontentStartPage> {
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }

//   @override
//   void dispose() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Kontent"),
//         backgroundColor: Theme.of(context).primaryColor,
//         foregroundColor: Colors.white,
//         titleTextStyle:
//             const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           const Padding(
//             padding: EdgeInsets.all(20),
//             child: Image(
//                 image: AssetImage('assets/images/TransparentLogoKontent.png')),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: KontentButton(
//                 onPressed: () {
//                   // ...
//                 },
//                 child: const Text('Start')),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kontent/kontentPages/intro/kontent_login_page.dart';
import 'package:kontent/kontentPages/intro/kontent_registration_page.dart';
import 'package:kontent/kontentWidgets/kontent_button.dart';

class KontentStartPage extends StatefulWidget {
  @override
  _KontentStartPageState createState() => _KontentStartPageState();
}

class _KontentStartPageState extends State<KontentStartPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
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
