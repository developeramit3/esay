import 'package:flutter/material.dart';

class AccountProvider extends ChangeNotifier {
  bool _showShare = false;
  int _conter = 0;
  String _phoneNumber = "";
  bool _connect = true;
  int _userSize = 0;
  bool _fmll = false;
  var _prifc = 0;
  List _shear = [];
  String _urlGoofle = "";
  String _urlApple = "";
  List get shear =>_shear;
  String get urlGoofle =>_urlGoofle;
  String get urlApple =>_urlApple;
  bool _offerScr = false;
  int _prot = 0;
  bool _ref = false;
  int _like = 0;
  int _offerCounter;
  bool _sub1 = false;
  bool _sub6 = false;
  bool _sub12 = false;
  bool _timeIsAf = false;
  bool _tool = false;
  int _checkNull = 0;
  get prifc => _prifc;
  int get userSize => _userSize;
  int get prot => _prot;
  int get like => _like;
  bool get fmll => _fmll;
  String get phoneNumber => _phoneNumber;
  int get offerCounter => _offerCounter;
  bool get offerScr => _offerScr;
  bool get timeIsAfr => _timeIsAf;
  bool get getShowShare => _showShare;
  int get conter => _conter;
  int get checkNull => _checkNull;
  bool get sub1 => _sub1;
  bool get connect => _connect;
  bool get ref => _ref;
  bool get sub6 => _sub6;
  bool get sub12 => _sub12;
  bool get tool => _tool;

  void changeShowShare(bool showShare) {
    _showShare = showShare;
    notifyListeners();
  }

  void getBiln(int numb) {
    _prifc = numb;
  }
  void shearUrl(String google , apple , List list ){
    _shear = list;
    _urlApple = apple;
    _urlGoofle = google;
    notifyListeners();
  }
  void timeIsAfre(bool time) {
    _timeIsAf = time;
    notifyListeners();
  }

  void offerCount(int counter) {
    _offerCounter = counter;
    notifyListeners();
  }

  void fmlle(bool vo) {
    _fmll = vo;
    notifyListeners();
  }

  void getSubUser(bool su1, su6, su12) {
    _sub1 = su1;
    _sub6 = su6;
    _sub12 = su12;
    notifyListeners();
  }

  void toolsTrue(bool tool) {
    _tool = tool;
    notifyListeners();
  }

  void checkConnect(bool coo) {
    _connect = coo;
    notifyListeners();
  }

  void contr(int con) {
    _conter = con;
    notifyListeners();
  }

  void likeProv(int like) {
    _like = like;
    notifyListeners();
  }

  void refresh(bool re) {
    _ref = re;
    notifyListeners();
  }

  void protfo(int pro) {
    _prot = pro;
    notifyListeners();
  }

  void checkNul(int num) {
    _checkNull = num;
    notifyListeners();
  }

  void offerS(bool offer) {
    _offerScr = offer;
    notifyListeners();
  }

  void userL(int size) {
    _userSize = size;
    notifyListeners();
  }

  void phoneNum(String phone) {
    _phoneNumber = phone;
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
