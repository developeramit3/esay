import 'package:flutter/material.dart';

class CodeProvider extends ChangeNotifier {
  DateTime _dateTime = DateTime.now();
  String _code = "";
  double _cost = 0.0;
  String _codeId = "";
  List<String> _codes = [];

  DateTime get getTimestamp => _dateTime;
  String get getCode => _code;
  double get getCost => _cost;
  String get getCodeId => _codeId;
  List<String> get getCodes => _codes;

  void changeTimestamp(DateTime dateTime) {
    _dateTime = dateTime;
    notifyListeners();
  }

  void changeCode(String code) {
    _code = code;
    notifyListeners();
  }

  void changeCost(double cost) {
    _cost = cost;
    notifyListeners();
  }

  void changeCodeId(String codeId) {
    _codeId = codeId;
    notifyListeners();
  }

  void changeCodes(String code) {
    _codes.add(code);
    notifyListeners();
  }

  void removeCodes() {
    _codes.clear();
    notifyListeners();
  }
}
