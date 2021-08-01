import 'package:esay/services/firestore_database.dart';
import 'package:esay/widgets/sucess_sharing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_localizations.dart';

validatePhone(BuildContext context, String codeDs ,  String code, String phone, String storeId,
    int days, double calc, String easyCost, var scaffoldKey, String storeName) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Wrap(
          children: [
            Text(AppLocalizations.of(context).translate('storeShare10')),
            Text(" "),
            Directionality(
                textDirection: TextDirection.ltr, child: Text(phone)),
            Text(" "),
            Text(AppLocalizations.of(context).translate('storeShare11')),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(AppLocalizations.of(context).translate('Cancel'),
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
              color: Colors.blue[700],
              child: Text(AppLocalizations.of(context).translate('Confirm'),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: () async {
                Navigator.pop(context);
                final firestoreDatabase =
                    Provider.of<FirestoreDatabase>(context, listen: false);
                await firestoreDatabase.checkUser(context,codeDs , code, phone, storeId,
                    days, calc, easyCost, storeName, scaffoldKey);
              }),
        ],
      );
    },
  );
}
