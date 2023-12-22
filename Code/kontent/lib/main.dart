import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kontent/examples/examples.dart';
import 'package:kontent/kontentPages/home/kontent_account_page.dart';
import 'package:kontent/kontentPages/home/kontent_downloads_page.dart';
import 'package:kontent/kontentPages/home/kontent_home_page.dart';
import 'package:kontent/kontentPages/home/kontent_search_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kontent/kontentPages/home/kontent_selected_page.dart';
import 'package:media_kit/media_kit.dart'; // Provides [Player], [Media], [Playlist] etc.
import 'package:kontent/kontentPages/intro/kontent_start_page.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const Kontent());
}

class Kontent extends StatelessWidget {
  const Kontent({super.key});
  final isLogged = false;

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
      home: isLogged
          ? const KontentMainWidget(title: 'Kontent')
          : const KontentStartPageWidget(),
      navigatorObservers: [routeObserver],
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
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    //const KontentHomePageBodyWidget(),
    const KontentSelectedPageBodyWidget(idPage: 'testpage'),
    const KontentSearchPageBodyWidget(),
    KontentDownloadPageBodyWidget(itemList: Examples.exampleDownloadList),
    const KontentAccountPageBodyWidget(),
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
