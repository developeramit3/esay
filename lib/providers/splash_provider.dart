import 'package:flutter/material.dart';

class SplashPovider extends ChangeNotifier {
  bool _splash = false;
  bool get getSplash => _splash;

  void changeSplash(bool splash) {
    _splash = splash;
    notifyListeners();
  }
}
