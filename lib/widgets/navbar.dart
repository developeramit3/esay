import 'package:esay/providers/bottom_animation_provider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../app_localizations.dart';

Widget bottomAnimation(BuildContext context) {
  return Consumer<CIndexProvider>(builder: (context, cIndexProvider, _) {
    return BottomNavigationBar(
        selectedFontSize: 15,
        unselectedFontSize: 15,
        currentIndex: cIndexProvider.getCIndex,
        backgroundColor: HexColor('#f8f8ff'),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: HexColor("#2c6bec"),
        unselectedItemColor: HexColor("#000000"),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w900),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: (value) {
          if (value == 0) {
            cIndexProvider.changeCIndex(value);
            cIndexProvider.changeNameNav("home");
            final newRouteName = "/homeScreen";
            bool isNewRouteSameAsCurrent = false;
            Navigator.popUntil(context, (route) {
              if (route.settings.name == newRouteName) {
                isNewRouteSameAsCurrent = true;
              }
              return true;
            });

            if (!isNewRouteSameAsCurrent) {
              Navigator.pushNamed(context, newRouteName);
            }
          } else if (value == 1) {
            cIndexProvider.changeCIndex(value);
            cIndexProvider.changeNameNav("profits");

            final newRouteName = "/moneyScreen";
            bool isNewRouteSameAsCurrent = false;
            Navigator.popUntil(context, (route) {
              if (route.settings.name == newRouteName) {
                isNewRouteSameAsCurrent = true;
              }
              return true;
            });

            if (!isNewRouteSameAsCurrent) {
              Navigator.pushNamed(context, newRouteName);
            }
          } else if (value == 2) {
            cIndexProvider.changeCIndex(value);
            cIndexProvider.changeNameNav("help");

            final newRouteName = "/helpScreen";
            bool isNewRouteSameAsCurrent = false;
            Navigator.popUntil(context, (route) {
              if (route.settings.name == newRouteName) {
                isNewRouteSameAsCurrent = true;
              }
              return true;
            });

            if (!isNewRouteSameAsCurrent) {
              Navigator.pushNamed(context, newRouteName);
            }
          } else {
            cIndexProvider.changeCIndex(value);
            final newRouteName = "/accountScreen";
            cIndexProvider.changeNameNav("account");

            bool isNewRouteSameAsCurrent = false;
            Navigator.popUntil(context, (route) {
              if (route.settings.name == newRouteName) {
                isNewRouteSameAsCurrent = true;
              }
              return true;
            });
            if (!isNewRouteSameAsCurrent) {
              Navigator.pushNamed(context, newRouteName);
            }
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              cIndexProvider.getnameNav == "home"
                  ? 'assets/images/offers blue.png'
                  : 'assets/images/offers gray.png',
              width: 30,
              height: 25,
            ),
            label: AppLocalizations.of(context).translate('Offers'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              cIndexProvider.getnameNav == "profits"
                  ? 'assets/images/profits blue.png'
                  : 'assets/images/profits gray.png',
              width: 30,
              height: 25,
            ),
            label: AppLocalizations.of(context).translate('Money'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              cIndexProvider.getnameNav == "help"
                  ? 'assets/images/help blue.png'
                  : 'assets/images/help gray.png',
              width: 30,
              height: 25,
            ),
            label: AppLocalizations.of(context).translate('Help'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              cIndexProvider.getnameNav == "account"
                  ? 'assets/images/my account blue.png'
                  : 'assets/images/my account gray.png',
              width: 30,
              height: 25,
            ),
            label: AppLocalizations.of(context).translate('Profile'),
          ),
        ]);
  });
}
