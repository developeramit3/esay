import 'package:esay/caches/sharedpref/shared_preference_helper.dart';
import 'package:esay/providers/auth_provider.dart';
import 'package:esay/services/firestore_database.dart';
import 'package:esay/widgets/sign_out.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../app_localizations.dart';
import 'back_btn.dart';

Widget appBar(BuildContext context, String title, {bool showBack, type}) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);

  return AppBar(
    backgroundColor: HexColor('#f8f8ff'),
    automaticallyImplyLeading: showBack == false ? false : true,
    centerTitle: true,
    toolbarHeight: 70,
    leadingWidth: 60,
    actions: [
      title == "account"
          ? FlatButton(
              color: Colors.transparent,
              onPressed: () async {
                SharedPreferenceHelper().getStorePrefs().then((value) async {
                  if (value == "") {
                    final newRouteName = "/loginStoreScreen";
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
                  } else {
                    final firestoreDatabase =
                        Provider.of<FirestoreDatabase>(context, listen: false);
                    await firestoreDatabase.enterStore(context, value);
                  }
                });
              },
              child: Icon(
                Icons.store,
                color: Colors.transparent,
              ))
          : Container(),
    ],
    leading: showBack == false
        ? title == "account"
            ? Container(
                child: authProvider.userModel.phoneNumber == ""
                    ? IconButton(
                        color: Colors.transparent,
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/out.png',
                          width: 25,
                          color: Colors.transparent,
                        ))
                    : IconButton(
                        onPressed: () {
                          confirmSignOut(context);
                        },
                        icon: Image.asset(
                          'assets/images/out.png',
                          width: 25,
                        )))
            : Container()
        : type == null
            ? backBtn(context)
            : backBtnStore(context),
    title: title == "Home"
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 100,
                  alignment: Alignment.center,
                  color: HexColor('#f8f8ff'),
                  child: Center(
                    child: Image.asset(
                      'assets/images/easy.png',
                      fit: BoxFit.fitHeight,
                    ),
                  )),
              showBack == false ? SizedBox(width: 70) : SizedBox(width: 60)
            ],
          )
        : title == "money"
            ? Row(
                mainAxisAlignment: showBack == false
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 80,
                      alignment: Alignment.center,
                      color: HexColor('#f8f8ff'),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('myMoneyTitle'),
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 23),
                        ),
                      )),
                  showBack == false ? SizedBox(width: 70) : SizedBox(width: 0)
                ],
              )
            : title == "help"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 80,
                          alignment: Alignment.center,
                          color: HexColor('#f8f8ff'),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('helpTitle'),
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 23),
                            ),
                          )),
                      showBack == false
                          ? SizedBox(width: 70)
                          : SizedBox(width: 0)
                    ],
                  )
                : title == "account"
                    ? Padding(
                        padding: const EdgeInsets.only(right: 70),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: 80,
                                  alignment: Alignment.center,
                                  color: HexColor('#f8f8ff'),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('accountTitle'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 23),
                                    ),
                                  )),
                              showBack == false
                                  ? SizedBox(width: 70)
                                  : SizedBox(width: 0)
                            ],
                          ),
                        ),
                      )
                    : title == "getOffer"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 80,
                                  alignment: Alignment.center,
                                  color: HexColor('#f8f8ff'),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('getOffer'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 23),
                                    ),
                                  )),
                              showBack == false
                                  ? SizedBox(width: 0)
                                  : SizedBox(width: 60)
                            ],
                          )
                        : title == "loginUserTitle"
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 80,
                                      alignment: Alignment.center,
                                      color: HexColor('#f8f8ff'),
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('loginUserTitle'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 23),
                                        ),
                                      )),
                                  showBack == false
                                      ? SizedBox(width: 0)
                                      : SizedBox(width: 60)
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 80,
                                      alignment: Alignment.center,
                                      color: HexColor('#f8f8ff'),
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate(title),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      )),
                                  showBack == false
                                      ? SizedBox(width: 0)
                                      : SizedBox(width: 60)
                                ],
                              ),
    bottom: title == "Home"
        ? PreferredSize(
            preferredSize: Size.fromHeight(30), child: Column(children: []))
        : null,
    elevation: 0.0,
  );
}
