import 'dart:ui';
import 'package:esay/widgetEdit/custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CustomDialogQr extends StatefulWidget {
  final String title, descriptions, text, code;
  final Image img;

  CustomDialogQr(
      {Key key, this.title, this.descriptions, this.text, this.img, this.code})
      : super(key: key);

  @override
  _CustomDialogQrState createState() => _CustomDialogQrState();
}

class _CustomDialogQrState extends State<CustomDialogQr> {
  bool _colors = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _colors = true;
                      });
                    },
                    child: QrImage(
                      data: widget.code,
                      version: QrVersions.auto,
                      size: 300.0,
                    ),
                  ),
                  _colors
                      ? Align(
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
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
