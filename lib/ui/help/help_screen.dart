import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:esay/functions/url_launcher.dart';
import 'package:esay/providers/bottom_animation_provider.dart';
import 'package:esay/widgets/get_deviceId.dart';
import 'package:esay/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';
import '../../widgets/appbar.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  Future<bool> _willPopScope() async {
    Navigator.of(context).pop();
    final cIndexProvider = Provider.of<CIndexProvider>(context, listen: false);
    cIndexProvider.changeCIndex(0);
    cIndexProvider.changeNameNav("home");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopScope,
      child: Scaffold(
        appBar: appBar(context, "help", showBack: false),
        bottomNavigationBar: bottomAnimation(context),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Image.asset(
                'assets/animations/help.gif',
                height: 180,
                width: 180,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 25),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate('helpNote1'),
                        style: TextStyle(
                            fontSize: 18,
                            color: HexColor("#000000"),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        AppLocalizations.of(context).translate('helpNote2'),
                        style: TextStyle(
                            fontSize: 18,
                            color: HexColor("#000000"),
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
              ),
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        launchWebsite(context, "https://web.telegram.org");
                      },
                      child: Image.asset(
                        'assets/images/telegram.png',
                        height: 60,
                        width: 60,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        launchWebsite(context, "https://www.messenger.com");
                      },
                      child: Image.asset(
                        'assets/images/messenger.png',
                        height: 60,
                        width: 60,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        launchWebsite(context, "https://www.facebook.com");
                      },
                      child: Image.asset(
                        'assets/images/facebook.png',
                        height: 60,
                        width: 60,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/email.png',
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        funcOpenMailComposer(context, "easyapp@pm.me");
                      },
                      child: Text(
                        AppLocalizations.of(context).translate('easyapp@pm.me'),
                        style: TextStyle(
                          fontSize: 20,
                          color: HexColor("#49494a"),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 150,
                ),
                FlatButton(
                    height: 50,
                    minWidth: 200,
                    color: HexColor('#f8f8ff').withOpacity(0.90),
                    onPressed: () async {
                      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                      String deviceId;
                      if (Platform.isAndroid) {
                        AndroidDeviceInfo androidInfo =
                            await deviceInfo.androidInfo;
                        deviceId = androidInfo.androidId;
                        getDeviceId(context, deviceId);
                      } else if (Platform.isIOS) {
                        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
                        deviceId = iosInfo.identifierForVendor;
                        getDeviceId(context, deviceId);
                      }
                    },
                    child: Text(
                        AppLocalizations.of(context).translate('deviceId'),
                        style: TextStyle(
                            fontSize: 17,
                            color: HexColor("#49494a"),
                            fontWeight: FontWeight.bold))),
                SizedBox(
                  height: 10,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
