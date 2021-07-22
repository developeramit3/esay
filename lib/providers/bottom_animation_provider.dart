import 'package:flutter/material.dart';

class CIndexProvider extends ChangeNotifier {
  int _cIndex = 0;
  int get getCIndex => _cIndex;
  String _nameNav = "home";
  String get getnameNav => _nameNav;

  void changeCIndex(int cIndex) {
    _cIndex = cIndex;
    notifyListeners();
  }

  void changeNameNav(String nameNav) {
    _nameNav = nameNav;
    notifyListeners();
  }
}
