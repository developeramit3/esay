import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../app_localizations.dart';
import '../../widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SharingScreen extends StatelessWidget {
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
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                        Text(
                          AppLocalizations.of(context).translate('sharing1-sub1'),
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context).translate('sharing1-sub2'),
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
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.deepPurple[800],
                              borderRadius: BorderRadius.circular(20)),
                          height: 200,
                          width: MediaQuery.of(context).size.width - 50,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            child: Column(children: [
                              Align(
                                alignment: Alignment(0.90, -0.4),
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
                                            "9.",
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
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "5.",
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
                        Text(
                          AppLocalizations.of(context).translate('sharing3'),
                          style: TextStyle(fontSize: 17, color: Colors.grey[600]),
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
                                "6 شهر",
                                style: TextStyle(
                                    color: HexColor('#2c6bec'),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 23),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "9.",
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
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "3.",
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
                        Text(
                          AppLocalizations.of(context).translate('sharing4'),
                          style: TextStyle(fontSize: 17, color: Colors.grey[600]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              border: Border.all(color: Colors.grey[700], width: 2)),
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
                                              "9.",
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
                        Text(
                          AppLocalizations.of(context).translate('sharing5'),
                          style: TextStyle(fontSize: 17, color: Colors.grey[600]),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 150),
                          child: Text(
                            AppLocalizations.of(context).translate('sharing6'),
                            style:
                            TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
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
}
