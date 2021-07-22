import 'package:esay/providers/auth_provider.dart';
import 'package:esay/providers/loading_provider.dart';
import 'package:esay/widgets/edit_number.dart';
import 'package:esay/widgets/loading.dart';
import 'package:esay/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';
import '../../models/user_model.dart';
import '../../widgets/appbar.dart';

class SMSScreen extends StatefulWidget {
  SMSScreen(this.userModel, this.typeAuth);
  final UserModel userModel;
  final String typeAuth;
  @override
  _SMSScreenState createState() => _SMSScreenState();
}

class _SMSScreenState extends State<SMSScreen> {
  final TextEditingController _pinPutController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    Future.delayed(Duration(seconds: 1), () async {
      await authProvider.registerWithPhoneNumber(
          context, widget.userModel, widget.typeAuth);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 20),
                Image.asset(
                  'assets/animations/code sent gif.gif',
                  height: 180,
                  width: 180,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  AppLocalizations.of(context).translate('smsNote'),
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    widget.userModel.phoneNumber,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[700],
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {
                    int lenght = widget.userModel.countryCode.length;
                    alertEditNumber(
                        context,
                        widget.userModel.phoneNumber.substring(lenght),
                        widget.userModel.countryCode,
                        widget.typeAuth);
                  },
                  child: Text(
                    AppLocalizations.of(context).translate('editNumber'),
                    style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  color: Colors.white,
                  margin: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 80, right: 80),
                  padding: const EdgeInsets.all(20.0),
                  child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(letterSpacing: 0.5),
                          controller: _pinPutController,
                          validator: (value) {
                            if (value.isEmpty || value.length < 6) {
                              return AppLocalizations.of(context)
                                  .translate('smsError');
                            }
                            return null;
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                          ],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: TextStyle(
                                  color: Colors.grey[800], letterSpacing: 0.5),
                              hintText: AppLocalizations.of(context)
                                  .translate('enterSMS'),
                              fillColor: Colors.white70))),
                ),
                SizedBox(height: 30),
                FlatButton(
                    height: 50,
                    minWidth: 300,
                    color: HexColor('#2c6bec'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        final authProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        await authProvider.signInWithPhoneNumber(
                            context, _pinPutController.text, widget.typeAuth);
                      }
                    },
                    child: Consumer<LoadingProvider>(
                        builder: (context, loadingProvider, _) {
                      return loadingProvider.getLoading
                          ? loadingBtn(context)
                          : Text(
                              widget.typeAuth == "register"
                                  ? AppLocalizations.of(context)
                                      .translate('createAccount')
                                  : AppLocalizations.of(context)
                                      .translate('login'),
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900),
                            );
                    })),
                SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    final authProvider =
                        Provider.of<AuthProvider>(context, listen: false);
                    Future.delayed(Duration(seconds: 1), () async {
                      await authProvider.registerWithPhoneNumber(
                          context, widget.userModel, widget.typeAuth);
                    });
                  },
                  child: Text(
                    AppLocalizations.of(context).translate('returnNumber'),
                    style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: HexColor('#49494a'),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
