import 'package:esay/functions/favorite.dart';
import 'package:esay/services/firestore_database.dart';
import 'package:esay/widgetEdit/test.dart';
import 'package:esay/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../app_localizations.dart';
import '../offers/offers_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final LocalStorage storageCodes = LocalStorage('codes');

  @override
  void initState() {
    super.initState();
    SetNot.getDataUsers(context);
    storageCodes.ready.then((value) {
      print(value);
    });
    Future.delayed(Duration(seconds: 1), () async {
      final firestoreDatabase =
          Provider.of<FirestoreDatabase>(context, listen: false);
      await firestoreDatabase.getStores(context);
      await firestoreDatabase.checkRate(context);
      await firestoreDatabase.checkUserSharing(context);
    });
    getFavoritesId(context);
  }

  Future<bool> _willPopScope() async {
    Alert(
      context: context,
      type: AlertType.error,
      title: AppLocalizations.of(context).translate("Do you want to exit?"),
      buttons: [
        DialogButton(
          color: Theme.of(context).iconTheme.color,
          child: Text(
            AppLocalizations.of(context).translate("No"),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
        DialogButton(
          color: Theme.of(context).iconTheme.color,
          child: Text(
            AppLocalizations.of(context).translate("Yes"),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            SystemNavigator.pop();
          },
          width: 120,
        )
      ],
    ).show();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _willPopScope,
        child: Scaffold(
            key: _scaffoldKey,
            bottomNavigationBar: bottomAnimation(context),
            body: OffersScreen()));
  }
}
