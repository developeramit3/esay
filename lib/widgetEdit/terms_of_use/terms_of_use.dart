import 'package:flutter/material.dart';
import 'package:esay/widgets/appbar.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Home", showBack: true),
      body: Center(
        child: Column(
          // mainAxisAlignment:MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
                Text(
                  "شروط الاستخدام",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
          ],
        ),
      ),
    );
  }
}
