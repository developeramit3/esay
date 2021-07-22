import 'package:esay/providers/loading_provider.dart';
import 'package:esay/widgets/loading.dart';
import 'package:esay/widgets/unordered_list.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../app_localizations.dart';
import '../providers/auth_provider.dart';
import '../widgets/appbar.dart';
import 'package:esay/widgetEdit/accont_acsept.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: appBar(context, "Home", showBack: false),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Image.asset(
              'assets/animations/welcome.gif',
              height: 200,
              width: 200,
            ),
            SizedBox(height: 15),
            Text(
              AppLocalizations.of(context).translate('titleWelcome'),
              style: TextStyle(
                  fontSize: 25,
                  color: HexColor("#000000"),
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 50,
            ),
            UnorderedList([
              AppLocalizations.of(context).translate('subTitleWelcome1'),
              AppLocalizations.of(context).translate('subTitleWelcome2'),
              AppLocalizations.of(context).translate('subTitleWelcome3'),
              AppLocalizations.of(context).translate('subTitleWelcome4'),
            ]),
            SizedBox(
              height: 50,
            ),
            FlatButton(
                height: 50,
                minWidth: 280,
                color: HexColor('#2c6bec'),
                onPressed: () async {
                  await authProvider.signInAnonymously(context);
                },
                child: Consumer<LoadingProvider>(
                    builder: (context, loadingProvider, _) {
                  return loadingProvider.getLoading
                      ? loadingBtn(context)
                      : Text(
                          AppLocalizations.of(context)
                              .translate('btnTextWelcome'),
                          style: TextStyle(
                              fontSize: 30,
                              color: HexColor('#fdfcfa'),
                              fontWeight: FontWeight.bold),
                        );
                })),
            SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context).translate('offerTextWelcome'),
              style: TextStyle(
                  fontSize: 16, color: HexColor('#49494a'), wordSpacing: -1),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PrivacyPolicy(
                                    text: "سياسة الاستخدام",
                                  )));
                    },
                    child: Text('سياسة الاستخدام  ؟',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    ),),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PrivacyPolicy(
                                    text: "سياسة الخصوصية",
                                  )));
                    },
                    child: Text(
                      'سياسة الخصوصية  ؟',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
