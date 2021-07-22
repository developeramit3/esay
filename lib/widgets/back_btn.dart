import 'package:esay/providers/bottom_animation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget backBtn(BuildContext context) {
  return FlatButton(
    onPressed: () => Navigator.of(context).pop(),
    child: Icon(
      Icons.arrow_back,
      color: Colors.black,
      size: 30,
    ),
  );
}

Widget backBtnStore(BuildContext context) {
  final cIndexProvider = Provider.of<CIndexProvider>(context, listen: false);

  return FlatButton(
    onPressed: () {
      cIndexProvider.changeCIndex(0);
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
    },
    child: Icon(
      Icons.arrow_back,
      color: Colors.black,
      size: 30,
    ),
  );
}
