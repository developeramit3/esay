import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay/ui/money/anlitxt.dart';


class MoneyAdmin extends StatefulWidget {
  const MoneyAdmin({Key key}) : super(key: key);

  @override
  _MoneyAdminState createState() => _MoneyAdminState();
}

class _MoneyAdminState extends State<MoneyAdmin> {
  List<int> myList = [];
  List<int> customer = [];
  List<int> total = [];
  List<int> profitUser = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _drawProucts("users", Icons.person),
              _codesActive(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _codeNuActive(),
              _offer(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _stores(),
              _mode(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _money(),
              InkWell(
                onTap: () async {

                  final _firebase = FirebaseFirestore.instance;
                  await _firebase
                      .collection("sharing_users")
                      .get()
                      .then((value) {
                    value.docs.forEach((element1) {
                      if (myList
                          .every((eleent) => eleent != element1['easyCost'])) {
                        myList.add(element1['easyCost'].toInt());
                      }
                      //myList.add(element['easyCost']);
                    });
                  }).then((value) async {
                    final _firebase = FirebaseFirestore.instance;
                    await _firebase.collection("stores").get().then((value) {
                      value.docs.forEach((eleme) {
                        int addCus = int.parse(eleme['customers']);
                        var addTotal = double.parse(eleme['total']);
                        print(addTotal);
                        customer.add(addCus);
                        total.add(addTotal.toInt());
                        //myList.add(element['easyCost']);
                      });
                    });
                    _firebase.collection("users").get().then((value) {
                      value.docs.forEach((eleme) {
                        print(eleme['profit']);
                        profitUser.add(eleme['profit'].toInt());
                        print(profitUser);
                        //myList.add(element['easyCost']);
                      });
                      num sum = 0;
                      num numb = 0;
                      num cust = 0;
                      num ttal = 0;
                      customer.forEach((num e) {
                        cust += e;
                      });
                      total.forEach((num e) {
                        ttal += e;
                      });
                      myList.forEach((num e) {
                        sum += e;
                      });
                      profitUser.forEach((num e) {
                        numb += e;
                      });
                      print(numb);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AnlTs(
                                    number: sum.toString(),
                                    profit: numb.toString(),
                                    customer: cust.toString(),
                                    total: ttal.toString(),
                                  )));
                    }).then((value) {
                      myList.clear();
                      profitUser.clear();
                      customer.clear();
                      total.clear();
                    });
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 150,
                  width: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "احصايات الاشتراك",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget checkPr(int nmber, var length) {
    if (length.length == 0) {
      return Text(
        "${nmber.toString()}",
        style: TextStyle(
            fontSize: 60,
            color: HexColor('#2c6bec'),
            fontWeight: FontWeight.w900),
      );
    } else {
      Text('0.0');
    }
  }

  Widget _drawProucts(String id, IconData icon) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(id).snapshots(),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
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
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "عداد المسجلين",
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
      stream: FirebaseFirestore.instance
          .collection('codes')
          .where("close", isEqualTo: true)
          .snapshots(),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
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
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "الكواد الستخدم",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
        }
      },
    );
  }

  Widget _codeNuActive() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("codes")
          .where("close", isEqualTo: false)
          .snapshots(),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
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
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "الكود غير مستخدام",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
        }
      },
    );
  }

  Widget _offer() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("offers").snapshots(),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
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
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "العروض ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
        }
      },
    );
  }

  Widget _stores() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("stores").snapshots(),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
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
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "المتاجر",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
        }
      },
    );
  }

  Widget _mode() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("tools").snapshots(),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  snapshot.data.docs[1]['active_mode'] == true
                      ? Text(
                          "مدفوع",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          "مجاني",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                ],
              ),
            );
        }
      },
    );
  }

  Widget _money() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("sharing_users").snapshots(),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "عداد الاشتراكات ${snapshot.data.docs.length}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            );
        }
      },
    );
  }
}
