import 'dart:ui';
import 'package:esay/widgetEdit/custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text , code;
  final Image img;
  const CustomDialogBox({Key key, this.title, this.descriptions, this.text, this.img, this.code}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
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
              Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              QrImage(
                data: widget.code,
                version: QrVersions.auto,
                size: 200.0,

              ),
              SizedBox(height: 10,),
              Text(widget.code,style: TextStyle(color: Colors.blue,fontSize: 18,fontWeight: FontWeight.w700),),
              SizedBox(height: 22,),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                        height: 40,
                        width: 90,
                        color: Colors.blue,
                        child: Text(widget.text,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w900),))),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset("assets/images/celebrating emoji.png")
            ),
          ),
        ),
      ],
    );
  }
}