import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../app_localizations.dart';

alertLogin(context) {
  Alert(
      type: AlertType.warning,
      context: context,
      title: AppLocalizations.of(context).translate("You must login"),
      style: AlertStyle(titleStyle: TextStyle(fontWeight: FontWeight.bold)),
      buttons: [
        DialogButton(
          color: HexColor('#2c6bec'),
          onPressed: () {
            Navigator.of(context).pop();
            final newRouteName = "/registerUserScreen";
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
          },
          child: Text(
            AppLocalizations.of(context).translate("Register"),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        DialogButton(
          color: HexColor('#2c6bec'),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context).pop();
            final newRouteName = "/loginUserScreen";
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
          },
          child: Text(
            AppLocalizations.of(context).translate("Login"),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ]).show();
}
