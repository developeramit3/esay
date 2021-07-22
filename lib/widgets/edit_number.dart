import 'package:esay/models/user_model.dart';
import 'package:esay/ui/account/sms_sceen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_localizations.dart';

final _formKey = GlobalKey<FormState>();

alertEditNumber(context, String phone, String countryCode, String type) {
  TextEditingController textEditingController =
      TextEditingController(text: phone);

  return showDialog(
    context: context,
    builder: (context) {
      return Form(
          key: _formKey,
          child: AlertDialog(
            content: Directionality(
              textDirection: TextDirection.ltr,
              child: TextFormField(
                controller: textEditingController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty || value.length < 9) {
                    return AppLocalizations.of(context).translate('phoneError');
                  }
                  return null;
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(9),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(AppLocalizations.of(context).translate('Cancel'),
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                color: Colors.blue[700],
                child: Text(AppLocalizations.of(context).translate('Edit'),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.pop(context);
                    String phone = countryCode + textEditingController.text;
                    UserModel _userModel = UserModel(phoneNumber: phone);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SMSScreen(_userModel, type)));
                  }
                },
              ),
            ],
          ));
    },
  );
}
