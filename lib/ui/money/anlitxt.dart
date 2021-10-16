import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnlTs extends StatefulWidget {
  final String number;
  final String profit;
  final String customer;
  final String total;
  const AnlTs({Key key, this.total, this.number, this.profit, this.customer})
      : super(key: key);

  @override
  _AnlTsState createState() => _AnlTsState();
}

class _AnlTsState extends State<AnlTs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _getAniltes("ارباح الاشتراكات", widget.number),
                  _getAniltes("ارباح المستخدمين", widget.profit)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _getAniltes("ارباح المحلات", widget.total),
                  _getAniltes("عدد العملاء", widget.customer)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _drawProucts('1', 'subscription1'),
                  _drawProucts('12', 'subscription12m'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _drawProucts('1', 'subscription1'),
                  _drawProucts('6', 'subscription6m'),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _getAniltes(String text, String numb) {
    return Container(
      alignment: Alignment.center,
      height: 170,
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            numb,
            style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
          ),
        ],
      ),
    );
  }

  Widget _drawProucts(String month, String where) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where(where, isEqualTo: true)
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
              height: 170,
              width: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    ' عدد الاشتراك $month  شهر ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data.docs.length != null
                        ? "${snapshot.data.docs.length}"
                        : '0',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}
