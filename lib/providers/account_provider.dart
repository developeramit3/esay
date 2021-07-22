import 'package:flutter/material.dart';

class AccountProvider extends ChangeNotifier {
  bool _showShare = false;
  bool get getShowShare => _showShare;

  void changeShowShare(bool showShare) {
    _showShare = showShare;
    notifyListeners();
  }
}
