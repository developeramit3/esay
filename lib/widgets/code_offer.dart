import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../app_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:esay/widgetEdit/custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:esay/widgetEdit/test.dart';
import '../app_localizations.dart';
import 'package:esay/widgets/show_toast.dart';
class CodeGetShow extends StatefulWidget {
  final String code;
  final int time;
  CodeGetShow({Key key, this.code, this.time}) : super(key: key);
  @override
  _CodeGetShowState createState() => _CodeGetShowState();
}
class _CodeGetShowState extends State<CodeGetShow> {
  bool _colors = false;
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: shoDialog(widget.code, widget.time),
    );
  }

  Widget shoDialog(String code, int timeCode) {
    return Stack(
      overflow: Overflow.visible,
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          height: 500,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 40, 30, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Stack(
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          _colors = true;
                        });
                      },
                      child: QrImage(
                        data: code,
                        version: QrVersions.auto,
                        size: 300.0,
                      ),
                    ),
                    _colors
                        ?Container(
                      padding: EdgeInsets.symmetric(vertical: 110),
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Text(
                                  widget.code,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      letterSpacing: 1),
                                ),
                              )),
                        )
                        : Container(),
                  ],
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
    );
  }
}
