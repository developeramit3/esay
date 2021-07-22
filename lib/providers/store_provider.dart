import 'package:flutter/material.dart';

class StorePovider extends ChangeNotifier {
  int _lenght = 0;
  double _easyCost = 0.0;

  int get getLenght => _lenght;
  double get getEasyCost => _easyCost;

  void changeLenght(int lenght) {
    _lenght = lenght;
    notifyListeners();
  }

  void changeEasyCost(double easyCost) {
    _easyCost = easyCost;
    notifyListeners();
  }
}
