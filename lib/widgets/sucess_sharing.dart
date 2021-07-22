import 'package:flutter/material.dart';

import '../app_localizations.dart';

sucessSharing(BuildContext context, String easyCost, var scaffoldKey) {
  return showDialog(
    context: scaffoldKey.currentContext,
    builder: (context) {
      return AlertDialog(
        title: Text(
          AppLocalizations.of(context).translate('sucessSharing'),
          style: TextStyle(color: Colors.green, fontSize: 20),
        ),
        content: Text(AppLocalizations.of(context).translate('costEasy') +
            " " +
            easyCost +
            "شيكل"),
        actions: <Widget>[
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('Ok'),
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
