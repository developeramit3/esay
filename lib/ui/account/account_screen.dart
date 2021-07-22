import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay/caches/sharedpref/shared_preference_helper.dart';
import 'package:esay/models/code_model.dart';
import 'package:esay/providers/account_provider.dart';
import 'package:esay/providers/auth_provider.dart';
import 'package:esay/providers/bottom_animation_provider.dart';
import 'package:esay/services/firestore_database.dart';
import 'package:esay/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';
import '../../widgets/appbar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:esay/widgetEdit/dielog_qr.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final LocalStorage storageCodes = LocalStorage('codes');
  StreamController listCodes = StreamController<List<CodeModel>>();
  List<CodeModel> dataList = List();
  @override
  void initState() {
    super.initState();
    try {
      Future.delayed(Duration(seconds: 0), () {
        final firestoreDatabase =
            Provider.of<FirestoreDatabase>(context, listen: false);
        firestoreDatabase.getCodes(context);
      }).then((value) {
        getCodes();
      });
    } on Exception catch (_) {
      getCodes();
    }
  }

  @override
  void dispose() {
    listCodes.close();
    super.dispose();
  }

  void getCodes() {
    SharedPreferenceHelper().getCodesPrefs().then((value) {
      for (var element in value) {
        storageCodes.ready.then((data) {
          var items = storageCodes.getItem(element);
          DateTime endDateTime = DateTime.parse(items[0]['endDateTime']);
          if (DateTime.now().isBefore(endDateTime))
            dataList.add(CodeModel(
                code: items[0]['code'],
                storeName: items[0]['storeName'],
                endDateTime: items[0]['endDateTime']));
        });
        listCodes.add(dataList);
      }
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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final accountProvider =
        Provider.of<AccountProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: _willPopScope,
      child: Scaffold(
        appBar: appBar(context, "account", showBack: false),
        bottomNavigationBar: bottomAnimation(context),
        body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      if (authProvider.userModel.phoneNumber.isEmpty)
                        Image.asset(
                          'assets/images/acount.png',
                          height: 180,
                          width: 180,
                        ),
                      if (authProvider.userModel.phoneNumber.isNotEmpty)
                        accountProvider.getShowShare
                            ? InkWell(
                                onTap: () {
                                  final newRouteName = "/sharingScreen";
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
                                child: Image.asset(
                                  'assets/images/subs details.png',
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              )
                            : Container(),
                      SizedBox(
                        height: 30,
                      ),
                      if (authProvider.userModel.phoneNumber.isNotEmpty)
                        StreamBuilder<List<CodeModel>>(
                            stream: listCodes.stream,
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return Container();
                              } else {
                                if (snapshot.data.length == 0) {
                                  return Container();
                                }
                                List<CodeModel> data = snapshot.data;
                                return Container(
                                  child: DataTable(
                                      columns: <DataColumn>[
                                        DataColumn(
                                          label: Center(
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('code'),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Center(
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('storeNa2me'),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Center(
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('timeAccount'),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: data.map((e) {
                                        int endTime =
                                            DateTime.parse(e.endDateTime)
                                                    .millisecondsSinceEpoch +
                                                1000 * 30;
                                        return DataRow(
                                          cells: [
                                            DataCell(
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return CustomDialogQr(
                                                          title:
                                                              "رمز أيزي الخاص بك لهذا العرض هو",
                                                          text: "شكرا !",
                                                          code: e.code,
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  child: QrImage(
                                                    data: e.code,
                                                    version: QrVersions.auto,
                                                    size: 50.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Center(child: Text(e.storeName)),
                                            ),
                                            DataCell(
                                              Center(
                                                child: Directionality(
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    child: CountdownTimer(
                                                      endTime: endTime,
                                                      widgetBuilder: (_,
                                                          CurrentRemainingTime
                                                              time) {
                                                        int hours;
                                                        if (time.days != null) {
                                                          hours =
                                                              (time.days * 24) +
                                                                  time.hours;
                                                        }
                                                        return time.days == null
                                                            ? Text(
                                                                time.hours ==
                                                                        null
                                                                    ? '0  :  ${time.min}  :  ${time.sec}'
                                                                    : time.min ==
                                                                            null
                                                                        ? '0  :  0  :  ${time.sec}'
                                                                        : '${time.hours}  :  ${time.min}  :  ${time.sec}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    letterSpacing:
                                                                        0.5,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )
                                                            : Text(
                                                                time.days ==
                                                                        null
                                                                    ? '0  : 0 : ${time.min}  :  ${time.sec}'
                                                                    : time.hours ==
                                                                            null
                                                                        ? '0  :  ${time.min}  :  ${time.sec}'
                                                                        : time.min ==
                                                                                null
                                                                            ? '0  :  0  :  ${time.sec}'
                                                                            : ' $hours  :  ${time.min}  :  ${time.sec}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    letterSpacing:
                                                                        0.5,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              );
                                                      },
                                                    )),
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList()),
                                );
                              }
                            }),
                      SizedBox(
                        height: 30,
                      ),
                      if (authProvider.userModel.phoneNumber.isNotEmpty)
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('sharing_users')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) return Container();
                            if (!snapshot.hasData) return Container();
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Container();
                              default:
                                return snapshot.data.size != 0
                                    ? Container(
                                        child: Column(children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('sharing'),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        DataTable(
                                            columns: <DataColumn>[
                                              DataColumn(
                                                label: Center(
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate('storeName'),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                              DataColumn(
                                                label: Center(
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            'timeAccount'),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                            rows: snapshot.data.docs.map((e) {
                                              int endTime = e
                                                      .data()["endDateTime"]
                                                      .millisecondsSinceEpoch +
                                                  1000 * 30;

                                              return DataRow(
                                                cells: [
                                                  DataCell(
                                                    Center(
                                                        child: Text(e.data()[
                                                            "storeName"])),
                                                  ),
                                                  DataCell(
                                                    Center(
                                                      child: Directionality(
                                                          textDirection:
                                                              TextDirection.ltr,
                                                          child: CountdownTimer(
                                                            endTime: endTime,
                                                            widgetBuilder: (_,
                                                                CurrentRemainingTime
                                                                    time) {
                                                              return Directionality(
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                  child: Text(
                                                                    time.days
                                                                            .toString() +
                                                                        " " +
                                                                        "يوم",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        letterSpacing:
                                                                            0.5,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ));
                                                            },
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }).toList()),
                                      ]))
                                    : Container();
                            }
                          },
                        ),
                      authProvider.userModel.phoneNumber.isNotEmpty
                          ? Container()
                          : Container(
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 25, left: 25, top: 25),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('accountNote'),
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: HexColor("#49494a"),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                FlatButton(
                                    height: 50,
                                    minWidth: 200,
                                    color: HexColor('#2c6bec'),
                                    onPressed: () async {
                                      final newRouteName =
                                          "/registerUserScreen";
                                      bool isNewRouteSameAsCurrent = false;
                                      Navigator.popUntil(context, (route) {
                                        if (route.settings.name ==
                                            newRouteName) {
                                          isNewRouteSameAsCurrent = true;
                                        }
                                        return true;
                                      });

                                      if (!isNewRouteSameAsCurrent) {
                                        Navigator.pushNamed(
                                            context, newRouteName);
                                      }
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('addNewAccount'),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    final newRouteName = "/loginUserScreen";
                                    bool isNewRouteSameAsCurrent = false;
                                    Navigator.popUntil(context, (route) {
                                      if (route.settings.name == newRouteName) {
                                        isNewRouteSameAsCurrent = true;
                                      }
                                      return true;
                                    });

                                    if (!isNewRouteSameAsCurrent) {
                                      Navigator.pushNamed(
                                          context, newRouteName);
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('haveAccount'),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: HexColor('#49494a'),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate('login'),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: HexColor('#ff5757'),
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                    ],
                  ),
                ),
              ),

      ),
    );
  }
/* : Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                      children: [
                        _drawProducts("users",Icons.person),
                        _codesActive(),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                      children: [
                        _codeNuActive(),
                        _offer(),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                      children: [
                        _stores(),
                        _mode(),
                      ],
                    ),
                     ],
                ),
              ),*/
  Widget _drawProducts(String id , IconData icon ) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(id).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return Container(
              alignment: Alignment.center,
              height: 150,
              width: 170,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
                ,color: Colors.blue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${snapshot.data.docs.length.toString()}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10,),
                  Text("عداد المسجلين",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
        }
      },
    );
  }
  Widget _codesActive() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('codes').where("close",isEqualTo:true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return Container(
              alignment: Alignment.center,
              height: 150,
              width: 170,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
                ,color: Colors.blue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${snapshot.data.docs.length.toString()}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10,),
                  Text("الكواد الستخدم",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                ],
              ),
            );
        }
      },
    );
  }
  Widget _codeNuActive() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("codes").where("close",isEqualTo: false).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return Container(
              alignment: Alignment.center,
              height: 150,
              width: 170,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
                ,color: Colors.blue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${snapshot.data.docs.length.toString()}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10,),
                  Text("الكود غير مستخدام",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                ],
              ),
            );
        }
      },
    );
  }
  Widget _offer() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("offers").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return Container(
              alignment: Alignment.center,
              height: 150,
              width: 170,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
                ,color: Colors.blue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${snapshot.data.docs.length.toString()}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10,),
                  Text("العروض ",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                ],
              ),
            );
        }
      },
    );
  }
  Widget _stores() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("stores").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return Container(
              alignment: Alignment.center,
              height: 150,
              width: 170,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
                ,color: Colors.blue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${snapshot.data.docs.length.toString()}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10,),
                  Text("المتاجر",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                ],
              ),
            );
        }
      },
    );
  }
  Widget _mode() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("tools").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return Container(
              alignment: Alignment.center,
              height: 150,
              width: 170,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
                ,color: Colors.blue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10,),
                  snapshot.data.docs[0]['active_mode'] ==true ?
                  Text("مدفوع",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),):
                  Text("مجاني",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                ],
              ),
            );
        }
      },
    );
  }
}
