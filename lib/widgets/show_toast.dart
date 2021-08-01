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
void showToa(BuildContext context, {bool center}) {
  Toast.show(
    "ليس لديك اشتراك",
    context,
    duration: 2,
    gravity: center == null ? Toast.CENTER : Toast.CENTER,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}

void showToaSec(BuildContext context, {bool center}) {
  Toast.show(
    "لقد تم تفعيل الشتراك بنجاح",
    context,
    duration: 2,
    gravity: center == null ? Toast.CENTER : Toast.CENTER,
    backgroundColor: Colors.grey,
    textColor: Colors.white,
  );
}


void showToaCheck(BuildContext context, {bool center}) {
  Toast.show(
    "لقد نم اضافة شخص مسبقا",
    context,
    duration: 2,
    gravity: center == null ? Toast.CENTER : Toast.CENTER,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}
void showT(BuildContext context, {bool center}) {
  Toast.show(
    "الجواب خطا",
    context,
    duration: 2,
    gravity: center == null ? Toast.CENTER : Toast.CENTER,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}


void shoCodeD(BuildContext context, {bool center}) {
  Toast.show(
    "رقم الخصم خطا",
    context,
    duration: 2,
    gravity: center == null ? Toast.CENTER : Toast.CENTER,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}
