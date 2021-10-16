import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
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
        content: Text('"المبلغ للدفع:' + " " + easyCost + "شيكل"),
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

void dontHaveOfferCode(BuildContext context, {bool center}) {
  Toast.show(
    "لم يتبق لديك أي رموز لهذا العرض",
    context,
    duration: 2,
    gravity: center == null ? Toast.CENTER : Toast.CENTER,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}

void showToaSec(BuildContext context, {bool center}) {
  Toast.show(
    "لقد تم تفعيل الاشتراك بنجاح",
    context,
    duration: 2,
    gravity: center == null ? Toast.CENTER : Toast.CENTER,
    backgroundColor: Colors.grey,
    textColor: Colors.white,
  );
}

void showToaCheck(BuildContext context, {bool center}) {
  Toast.show(
    "هذا الرقم غير مسجل في إيزي",
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

void shoCodeSac(BuildContext context, {bool center}) {
  Toast.show(
    "تم الشتراك بنجاح",
    context,
    duration: 2,
    gravity: center == null ? Toast.CENTER : Toast.CENTER,
    backgroundColor: Colors.black,
    textColor: Colors.white,
  );
}

void shoLogin(BuildContext context, {bool center}) {
  Toast.show(
    "لقد تم اضافة رقم على هذه الجهاز مسبقا",
    context,
    duration: 2,
    gravity: center == null ? Toast.CENTER : Toast.CENTER,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}
