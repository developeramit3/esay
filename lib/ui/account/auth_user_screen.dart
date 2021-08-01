import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:esay/functions/check_auth.dart';
import 'package:esay/models/user_model.dart';
import 'package:esay/providers/bottom_animation_provider.dart';
import 'package:esay/providers/loading_provider.dart';
import 'package:esay/widgets/loading.dart';
import 'package:esay/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';
import '../../widgets/appbar.dart';
import '../../widgets/show_toast.dart';

class AuthUserScreen extends StatefulWidget {
  AuthUserScreen(this.typeAuth);
  final String typeAuth;
  @override
  _AuthUserScreenState createState() => _AuthUserScreenState();
}

class _AuthUserScreenState extends State<AuthUserScreen> {
  TextEditingController _phoneController;
  String countryCode = "+970";
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cIndexProvider = Provider.of<CIndexProvider>(context, listen: false);

    return Scaffold(
        appBar: appBar(context, "loginUserTitle", showBack: true),
        bottomNavigationBar: bottomAnimation(context),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Image.asset(
                  'assets/images/loginUser.jpg',
                  height: 180,
                  width: 180,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context).translate('addYourNumber'),
                  style: TextStyle(
                      fontSize: 20,
                      color: HexColor("#49494a"),
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Theme(
                            data: ThemeData(primaryColor: Colors.blue),
                            child: TextFormField(
                              textAlign: TextAlign.end,
                              controller: _phoneController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(9),
                              ],
                              validator: (value) {
                                if (value.isEmpty || value.length < 9) {
                                  return AppLocalizations.of(context)
                                      .translate('phoneError');
                                }
                                return null;
                              },
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)
                                    .translate("123456789"),
                                contentPadding: EdgeInsets.all(0.0),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.blue),
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.grey, letterSpacing: 0.5),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(width: 12),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: DropdownButton(
                          value: countryCode,
                          underline: Container(),
                          items: [
                            DropdownMenuItem(
                              child: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text("+970",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              value: "+970",
                            ),
                            DropdownMenuItem(
                              child: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text("+972",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              value: "+972",
                            ),
                            // DropdownMenuItem(
                            //     child: Directionality(
                            //         textDirection: TextDirection.ltr,
                            //         child: Text("+20",
                            //             style: TextStyle(
                            //                 fontWeight: FontWeight.bold))),
                            //     value: "+2"),
                          ],
                          onChanged: (value) {
                            setState(() {
                              countryCode = value;
                            });
                          }),
                    ),
                    SizedBox(width: 12),
                    Image.asset(
                      'assets/images/phone 2nd.png',
                      width: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(height: 50),
                FlatButton(
                    height: 50,
                    minWidth: 250,
                    color: HexColor('#2c6bec'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                        String deviceId;
                        if (_phoneController.text.isNotEmpty) {
                          if (Platform.isAndroid) {
                            AndroidDeviceInfo androidInfo =
                                await deviceInfo.androidInfo;
                            deviceId = androidInfo.androidId;
                          } else if (Platform.isIOS) {
                            IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
                            deviceId = iosInfo.identifierForVendor;
                          }
                          String phone = countryCode + _phoneController.text;
                          UserModel _userModel = UserModel(
                              phoneNumber: phone,
                              countryCode: countryCode,
                              deviceId: deviceId);
                          if (widget.typeAuth == "register") {
                            await checkUserRegister(
                                context, _userModel, widget.typeAuth);
                          } else {
                            await checkUserLogin(
                                context, _userModel, widget.typeAuth);
                          }
                        } else {
                          showToast("phoneNumberEmpty", Colors.red, context);
                        }
                      }
                    },
                    child: Consumer<LoadingProvider>(
                        builder: (context, loadingProvider, _) {
                      return loadingProvider.getLoading
                          ? loadingBtn(context)
                          : Text(
                              AppLocalizations.of(context)
                                  .translate('continue'),
                              style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            );
                    })),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context).translate('arriveSmsCode'),
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                widget.typeAuth == "login"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)
                                .translate('loginError'),
                            style: TextStyle(
                                fontSize: 16,
                                color: HexColor('#737373'),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          InkWell(
                            onTap: () {
                              cIndexProvider.changeCIndex(2);
                              cIndexProvider.changeNameNav("help");

                              final newRouteName = "/helpScreen";
                              bool isNewRouteSameAsCurrent = false;
                              Navigator.popUntil(context, (route) {
                                if (route.settings.name == newRouteName) {
                                  isNewRouteSameAsCurrent = true;
                                }
                                return true;
                              });

                              if (!isNewRouteSameAsCurrent) {
                                Navigator.pushNamed(context, newRouteName);
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('contactUs'),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: HexColor('#000000'),
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    : Container()
              ],
            ),
          ),
        ));
  }
}
