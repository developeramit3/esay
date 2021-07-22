import 'package:esay/providers/bottom_animation_provider.dart';
import 'package:esay/providers/code_provider.dart';
import 'package:esay/services/firestore_database.dart';
import 'package:esay/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';
import '../../widgets/appbar.dart';

class MoneyScreen extends StatefulWidget {
  @override
  _MoneyScreenState createState() => _MoneyScreenState();
}

class _MoneyScreenState extends State<MoneyScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () async {
      final firestoreDatabase =
          Provider.of<FirestoreDatabase>(context, listen: false);
      await firestoreDatabase.calcCostUser(context);
    });
  }

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
          appBar: appBar(context, "money", showBack: false),
          bottomNavigationBar: bottomAnimation(context),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'assets/animations/moneyNew.gif',
                  height: 180,
                  width: 180,
                ),
                SizedBox(height: 35),
                Column(
                  children: [
                    Consumer<CodeProvider>(builder: (context, codeProvider, _) {
                      return codeProvider.getCost > 0.0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate('congratilation'),
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: HexColor("#000000"),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Image.asset(
                                      'assets/images/fez.png',
                                      width: 40,
                                      height: 50,
                                    ),
                                  ),
                                ])
                          : Container();
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      AppLocalizations.of(context).translate('saved'),
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                          color: HexColor("#000000")),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Consumer<CodeProvider>(
                              builder: (context, codeProvider, _) {
                            return Text(
                              codeProvider.getCost.toStringAsFixed(1),
                              style: TextStyle(
                                  fontSize: 60,
                                  color: HexColor('#2c6bec'),
                                  fontWeight: FontWeight.w900),
                            );
                          }),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Image.asset(
                              'assets/images/shekel currency.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ]),
                    Text(
                      AppLocalizations.of(context).translate('untilNow'),
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                          color: HexColor("#000000")),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: Divider(
                    color: HexColor('#e8e7e7'),
                    thickness: 1,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              .translate('myMoneyNote1'),
                          style: TextStyle(
                              fontSize: 17,
                              color: HexColor("#49494a"),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .translate('myMoneyNote2'),
                          style: TextStyle(
                              fontSize: 17,
                              color: HexColor("#49494a"),
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                )
              ],
            ),
          ),
        ));
  }
}
