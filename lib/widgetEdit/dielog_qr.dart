import 'dart:ui';
import 'package:esay/widgetEdit/custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CustomDialogQr extends StatefulWidget {
  final String title, descriptions, text , code;
  final Image img;
  const CustomDialogQr({Key key, this.title, this.descriptions, this.text, this.img, this.code}) : super(key: key);

  @override
  _CustomDialogQrState createState() => _CustomDialogQrState();
}

class _CustomDialogQrState extends State<CustomDialogQr> {
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
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
              + Constants.padding, right: Constants.padding,bottom: Constants.padding
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 15,),
              QrImage(
                data: widget.code,
                version: QrVersions.auto,
                size: 300.0,
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ],
    );
  }
}