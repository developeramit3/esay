import 'package:flutter/material.dart';
import 'package:esay/widgets/appbar.dart';

class PrivacyPolicy extends StatelessWidget {
  final String text;
  const PrivacyPolicy({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Home", showBack: false),
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Center(
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
