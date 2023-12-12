import 'package:flutter/material.dart';
import 'package:kontent/kontentPages/kontent_account_page.dart';
import 'package:kontent/kontentPages/kontent_downloads_page.dart';
import 'package:kontent/kontentPages/kontent_home_page.dart';
import 'package:kontent/kontentPages/kontent_search_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const Kontent());
}

class Kontent extends StatelessWidget {
  const Kontent({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kontent',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x00007dff)),
        textTheme: GoogleFonts.comfortaaTextTheme(),
        useMaterial3: true,
      ),
      home: const KontentMainWidget(title: 'Kontent'),
    );
  }
}

class KontentMainWidget extends StatefulWidget {
  const KontentMainWidget({super.key, required this.title});

  final String title;

  @override
  State<KontentMainWidget> createState() => _KontentMainWidgetState();
}

class _KontentMainWidgetState extends State<KontentMainWidget> {
  int _selectedIndex = 1;
  static const _pages = <Widget>[
    KontentHomePageBodyWidget(),
    KontentSearchPageBodyWidget(),
    KontentDownloadPageBodyWidget(),
    KontentAccountPageBodyWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('kontent'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.download), label: 'Download'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account')
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}