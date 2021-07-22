import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../app_localizations.dart';

void showToast(String msg, Color color, BuildContext context, {bool center}) {
  Toast.show(
    AppLocalizations.of(context).translate(msg),
    context,
    duration: 2,
    gravity: center == null ? Toast.CENTER : Toast.CENTER,
    backgroundColor: color,
    textColor: Colors.white,
  );
}
