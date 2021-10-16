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
import 'package:esay/widgetEdit/terms_of_use/terms_of_use.dart';

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
                  fontSize: 16, color: HexColor('#49494a'), wordSpacing: 2),
            ),
            SizedBox(
              height: 35,
            ),
            Column(
              children: [
                Text(
                  "عند الضغط على متابعة فإنك توافق على",
                  style: TextStyle(
                    color: HexColor("#49494a"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivacyPolicy(
                                      text: 'سياسة الخصوصية و شروط الاستخدام',
                                    )));
                      },
                      child: Text(
                        "سياسة الخصوصية",
                        style: TextStyle(
                          color: HexColor("#49494a"),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Text(
                      " و",
                      style: TextStyle(
                        color: HexColor("#49494a"),

                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsOfUse()));
                      },
                      child: Text(
                        "شروط الاستخدام",
                        style: TextStyle(
                          color: HexColor("#49494a"),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
