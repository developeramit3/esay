import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../app_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';

showCodeDialog(BuildContext context, String code, int timeCode) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          insetPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 40, 30, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Center(
                        child:  QrImage(
                          data: code,
                          version: QrVersions.auto,
                          size: 300.0,
                        ),
                      ),
                      SizedBox(height: 20),
                      timeCode == 6
                          ? Text("* الرمز صالح لمدة $timeCode ساعات",
                              style: TextStyle(color: HexColor("#49494a")))
                          : Text("* الرمز صالح لمدة $timeCode ساعة",
                              style: TextStyle(color: HexColor("#49494a"))),
                      SizedBox(height: 20),
                      Center(
                        child: Container(
                          width: 120,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              AppLocalizations.of(context).translate("code3"),
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            color: HexColor('#2c6bec'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: -65,
                  child: Image.asset(
                    "assets/images/celebrating emoji.png",
                    width: 100,
                  )),
            ],
          )));
}
