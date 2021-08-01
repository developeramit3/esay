import 'package:flutter/material.dart';
import 'package:esay/widgets/appbar.dart';

class PrivacyPolicy extends StatelessWidget {
  final String text;
  const PrivacyPolicy({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Home", showBack: true),
      body: Column(
        // mainAxisAlignment:MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "سياسة الخصوصية",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "المملة",
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "بس لزم تكون موجودة",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerRight,
            child: Column(
              children: [
                Text("النص تاعها....",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                Text("النص تاعها....",
                    style: TextStyle(
                      fontSize: 20,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
