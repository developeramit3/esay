import 'package:flutter/material.dart';

class AccountProvider extends ChangeNotifier {
  bool _showShare = false;
  int  _conter = 0;
  bool _ref = false;
  bool _sub1 = false;
  bool _sub6 = false;
  bool _sub12 = false;
  bool _tool = false;
  int _checkNull = 0;
  bool get getShowShare => _showShare;
 int get conter => _conter;
 int get checkNull => _checkNull;
  bool get sub1 => _sub1;
  bool get ref => _ref;
  bool get sub6 => _sub6;
  bool get sub12 => _sub12;
  bool get tool => _tool;

  void changeShowShare(bool showShare) {
    _showShare = showShare;
    notifyListeners();
  }
  void getSubUser(bool su1,su6 , su12 ){
    _sub1 = su1;
    _sub6 = su6;
    _sub12 = su12;
    notifyListeners();
  }
  void toolsTrue (bool tool){
    _tool = tool;
  notifyListeners();
  }
  void contr (int con){
    _conter = con;
  notifyListeners();
  }
  void refresh (bool re){
    _ref = re;
    notifyListeners();
  }
  void checkNul (int num){
    _checkNull = num;
    notifyListeners();
  }

}

//Center(
//                                 child: Container(
//                                   height: 60,
//                                   width: MediaQuery.of(context).size.width - 70,
//                                   color: HexColor('#f8f8ff').withOpacity(0.90),
//                                   child: Center(
//                                     child: Text(
//                                       AppLocalizations.of(context)
//                                           .translate('offer2'),
//                                       style: TextStyle(
//                                           color: HexColor('#2c6bec'),
//                                           fontWeight: FontWeight.w900,
//                                           fontSize: 14),
//                                     ),
//                                   ),
//                                 ),
//                               ),
