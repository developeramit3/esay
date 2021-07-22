import 'package:esay/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_localizations.dart';

getDeviceId(context, String deviceId) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('deviceId'),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          content: Text(deviceId),
          actions: <Widget>[
            FlatButton(
              color: Colors.blue,
              child: Text(AppLocalizations.of(context).translate('Copy'),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pop(context);
                Clipboard.setData(ClipboardData(text: deviceId));
                showToast("sucessCopy", Colors.green, context);
              },
            ),
            FlatButton(
              child: Text(AppLocalizations.of(context).translate('Cancel'),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ]);
    },
  );
}
