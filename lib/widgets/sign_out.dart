import 'package:esay/providers/bottom_animation_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_localizations.dart';

confirmSignOut(BuildContext context) {
  final cIndexProvider = Provider.of<CIndexProvider>(context, listen: false);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            AppLocalizations.of(context)
                .translate("This will logout. Are you sure?"),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(AppLocalizations.of(context).translate("Cancel"),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            FlatButton(
              child: Text(AppLocalizations.of(context).translate("Yes"),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () async {
                await FirebaseAuth.instance.signInAnonymously();
                Navigator.of(context).pop();
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
            ),
          ],
        );
      });
}
