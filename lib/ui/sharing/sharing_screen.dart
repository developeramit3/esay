import 'dart:async';

import 'package:esay/models/code_model.dart';
import 'package:esay/widgetEdit/dielog_qr.dart';
import 'package:esay/widgetEdit/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../app_localizations.dart';
import '../../widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:esay/providers/auth_provider.dart';
class SharingScreen extends StatefulWidget {
  @override
  _SharingScreenState createState() => _SharingScreenState();
}

class _SharingScreenState extends State<SharingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Home", showBack: true),
      body: compine(),
    );
  }

  Widget compine() {

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('subscription').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return Container(
                margin: EdgeInsets.all(16),
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('sharing1'),
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                    ),
                    Text(
                      AppLocalizations.of(context).translate('sharing1-sub1'),
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              .translate('sharing1-sub2'),
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Image.asset(
                          'assets/images/interesting.png',
                          width: 35,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _dis(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        child: Column(children: [
                      Align(
                        alignment: Alignment(0.90, -0.9),
                        child: Container(
                          height: 30,
                          width: 100,
                          color: Colors.grey[200],
                          child: Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.orange[400],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate('sharing2'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                      color: Colors.orange[600]),
                                )
                              ])),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width - 50,
                          color: HexColor('#2c6bec'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                " 12 شهر",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 23),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${snapshot.data.docs[0]['12month_b']}.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "${snapshot.data.docs[0]["12month"]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                  ),
                                  Image.asset(
                                    'assets/images/shekel currency.png',
                                    width: 20,
                                    height: 20,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              Column(children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${snapshot.data.docs[0]['12month_1_b']}.",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            "${snapshot.data.docs[0]["12month_1"]}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20),
                                          ),
                                          Image.asset(
                                            'assets/images/shekel currency.png',
                                            width: 20,
                                            height: 20,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ]),
                                Text(
                                  "شهريا",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ])
                            ],
                          ),
                        ),
                      ),
                    ])),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        AppLocalizations.of(context).translate('sharing3'),
                        style: TextStyle(fontSize: 17, color: Colors.grey[600]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          border:
                              Border.all(color: HexColor('#2c6bec'), width: 2)),
                      height: 80,
                      width: MediaQuery.of(context).size.width - 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "6 أشهر",
                            style: TextStyle(
                                color: HexColor('#2c6bec'),
                                fontWeight: FontWeight.w900,
                                fontSize: 23),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${snapshot.data.docs[0]['6month_b']}.",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: HexColor('#2c6bec'),
                                    fontSize: 16),
                              ),
                              Text(
                                "${snapshot.data.docs[0]["6month"]}",
                                style: TextStyle(
                                    color: HexColor('#2c6bec'),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20),
                              ),
                              Image.asset(
                                'assets/images/shekel currency.png',
                                width: 20,
                                height: 20,
                                color: HexColor('#2c6bec'),
                              ),
                            ],
                          ),
                          Column(children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${snapshot.data.docs[0]['6month_1_b']}.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: HexColor('#2c6bec'),
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "${snapshot.data.docs[0]["6month_1"].toString()}",
                                        style: TextStyle(
                                            color: HexColor('#2c6bec'),
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20),
                                      ),
                                      Image.asset(
                                        'assets/images/shekel currency.png',
                                        width: 20,
                                        height: 20,
                                        color: HexColor('#2c6bec'),
                                      ),
                                    ],
                                  ),
                                ]),
                            Text(
                              "شهريا",
                              style: TextStyle(
                                  color: HexColor('#2c6bec'),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ])
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        AppLocalizations.of(context).translate('sharing4'),
                        style: TextStyle(fontSize: 17, color: Colors.grey[600]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.grey[700], width: 2)),
                      height: 80,
                      width: MediaQuery.of(context).size.width - 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "1 شهر",
                              style: TextStyle(
                                  color: HexColor('#2c6bec'),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 23),
                            ),
                            Column(children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${snapshot.data.docs[0]['1month_b']}.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              color: HexColor('#2c6bec'),
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "${snapshot.data.docs[0]["1month"].toString()}",
                                          style: TextStyle(
                                              color: HexColor('#2c6bec'),
                                              fontWeight: FontWeight.w900,
                                              fontSize: 20),
                                        ),
                                        Image.asset(
                                          'assets/images/shekel currency.png',
                                          width: 20,
                                          height: 20,
                                          color: HexColor('#2c6bec'),
                                        ),
                                      ],
                                    ),
                                  ]),
                              Text(
                                "شهريا",
                                style: TextStyle(
                                    color: HexColor('#2c6bec'),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ])
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 13),
                      alignment: Alignment.centerRight,
                      child: Text(
                        AppLocalizations.of(context).translate('sharing5'),
                        style: TextStyle(fontSize: 17, color: Colors.grey[600]),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 150),
                      child: Text(
                        AppLocalizations.of(context).translate('sharing6'),
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w900),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Text(
                        AppLocalizations.of(context).translate('sharing7'),
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1.1),
                      ),
                    ),
                  ],
                )));
        }
      },
    );
  }
  Widget _dis() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(authProvider.userModel.phoneNumber)
            .get(),
        builder: (context, snap) {
          return snap.hasData ? diKiontCheck(snap) : Container();
        });
  }

  Widget diKiontCheck(AsyncSnapshot sna) {
    if (sna.data['notf'].toString().isNotEmpty) {
      print("qqqqqqqqqqq");
      if (sna.data['notf'].toDate().isAfter(DateTime.now())) {
        var _endDate = sna.data['notf'].millisecondsSinceEpoch + 1000 * 30;
        return Container(
            decoration: BoxDecoration(
                color: Colors.deepPurple[800],
                borderRadius: BorderRadius.circular(20)),
            height: 200,
            width: MediaQuery.of(context).size.width - 50,
            child: Column(
                //  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'خصم على اشتراك أيزي السنوي لفترة محدودة',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialogQr(
                              title: "رمز أيزي الخاص بك لهذا العرض هو",
                              text: "شكرا !",
                              code: sna.data['codeEasy'],
                            );
                          });
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      child: QrImage(
                        data: sna.data['codeEasy'],
                        version: QrVersions.auto,
                        //size: 50.0,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "استخدام هذه الرمز عند الاشتراك لتحصل على خصم 20 %",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ينتهي هذه الخصم خلال : ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Directionality(
                          textDirection: TextDirection.ltr,
                          child: CountdownTimer(
                            endTime: _endDate,
                            widgetBuilder: (_, CurrentRemainingTime time) {
                              int hours;
                              if (time.days != null) {
                                hours = (time.days * 24) + time.hours;
                              }
                              return time.days == null
                                  ? Text(
                                      time.hours == null
                                          ? '0  :  ${time.min}  :  ${time.sec}'
                                          : time.min == null
                                              ? '0  :  0  :  ${time.sec}'
                                              : '${time.hours}  :  ${time.min}  :  ${time.sec}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.orange,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      time.days == null
                                          ? '0 : 0 : ${time.min} : ${time.sec}'
                                          : time.hours == null
                                              ? '0 : ${time.min} : ${time.sec}'
                                              : time.min == null
                                                  ? '0 : 0 : ${time.sec}'
                                                  : ' $hours : ${time.min} : ${time.sec}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          letterSpacing: 0.0,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    );
                            },
                          )),
                    ],
                  )
                ]));
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }
}
