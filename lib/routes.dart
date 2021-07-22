import 'package:esay/ui/account/account_screen.dart';
import 'package:esay/ui/account/auth_user_screen.dart';
import 'package:esay/ui/help/help_screen.dart';
import 'package:esay/ui/home/home_screen.dart';
import 'package:esay/ui/money/money_screen.dart';
import 'package:esay/ui/offers/offer_details_screen.dart';
import 'package:esay/ui/sharing/sharing_screen.dart';
import 'package:esay/ui/store/login_store_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();
  static const String homeScreen = '/homeScreen';
  static const String moneyScreen = '/moneyScreen';
  static const String helpScreen = '/helpScreen';
  static const String accountScreen = '/accountScreen';
  static const String loginUserScreen = '/loginUserScreen';
  static const String registerUserScreen = '/registerUserScreen';
  static const String loginStoreScreen = '/loginStoreScreen';
  static const String offerDetailsScreen = '/offerDetailsScreen';
  static const String sharingScreen = '/sharingScreen';

  static final routes = <String, WidgetBuilder>{
    homeScreen: (BuildContext context) => HomeScreen(),
    moneyScreen: (BuildContext context) => MoneyScreen(),
    helpScreen: (BuildContext context) => HelpScreen(),
    accountScreen: (BuildContext context) => AccountScreen(),
    loginUserScreen: (BuildContext context) => AuthUserScreen("login"),
    registerUserScreen: (BuildContext context) => AuthUserScreen("register"),
    loginStoreScreen: (BuildContext context) => LoginStoreScreen(),
    offerDetailsScreen: (BuildContext context) => OfferDetailsScreen(),
    sharingScreen: (BuildContext context) => SharingScreen(),
  };
}
