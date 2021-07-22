import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Homecc extends StatelessWidget {
  const Homecc({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(CupertinoIcons.share,),
      ),
    );
  }
}
