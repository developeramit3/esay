import 'package:flutter/material.dart';

class RatingProvider extends ChangeNotifier {
  bool _show = false;
  int _type = 0;
  double _rate = 0.0;

  bool get getShow => _show;
  int get getType => _type;
  double get getRate => _rate;

  void changeType(int type) {
    _type = type;
    notifyListeners();
  }

  void changeShow(bool show) {
    _show = show;
    notifyListeners();
  }

  void changeRate(double rate) {
    _rate = rate;
    notifyListeners();
  }
}
