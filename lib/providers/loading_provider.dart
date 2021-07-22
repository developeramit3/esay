import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  bool _loading = false;
  bool _loading1 = false;
  bool get getLoading => _loading;
  bool get getLoading1 => _loading1;

  void changeLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void changeLoading1(bool loading1) {
    _loading1 = loading1;
    notifyListeners();
  }
}
