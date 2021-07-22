import 'package:flutter/material.dart';

class SharePovider extends ChangeNotifier {
  String _file;
  String get getFile => _file;

  void changeFile(String file) {
    _file = file;
    notifyListeners();
  }
}
