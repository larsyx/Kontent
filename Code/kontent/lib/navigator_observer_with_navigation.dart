import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavigatorObserverWithOrientation extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    _setOrientation();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _setOrientation();
  }

  void _setOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }
}
