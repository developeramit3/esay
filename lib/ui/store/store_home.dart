import 'package:esay/models/store_model.dart';
import 'package:esay/ui/store/store_confirmation_screen.dart';
import 'package:esay/ui/store/store_sharing_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../app_localizations.dart';
import '../../widgets/appbar.dart';

class StoreHome extends StatefulWidget {
  StoreHome({this.storeModel});
  final StoreModel storeModel;
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

GlobalKey<ScaffoldState> _scaffoldKey;

class _StoreHomeState extends State<StoreHome> {
  @override
  void initState() {
    super.initState();
    print("widget.storeModel.name${widget.storeModel.password}");
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  void dispose() {
    _scaffoldKey.currentState.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: appBar(context, "Home", showBack: true, type: true),
          key: _scaffoldKey,
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 60,
                child: AppBar(
                  elevation: 0,
                  backgroundColor: HexColor('#f8f8ff').withOpacity(0.80),
                  bottom: TabBar(
                    labelColor: Colors.black,
                    indicatorWeight: 5,
                    tabs: [
                      Tab(
                        child: Text(
                            AppLocalizations.of(context).translate('codeEasy'),
                            style: TextStyle(fontSize: 18)),
                      ),
                      Tab(
                        child: Text(
                          AppLocalizations.of(context).translate('easyShare'),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Container(
                      child: Center(
                          child: StoreConfirmationScreen(
                        storeModel: widget.storeModel,
                      )),
                    ),
                    Container(
                      child: Center(
                          child: StoreSharingScreen(
                        storeModel: widget.storeModel,
                        scaffoldKey: _scaffoldKey,
                      )),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
