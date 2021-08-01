import 'package:esay/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:esay/services/class_stream.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay/ui/account/account_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:esay/providers/account_provider.dart';
import 'package:provider/provider.dart';
import 'package:esay/ui/sharing/sharing_screen.dart';
Widget getText(context) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  if (authProvider.userModel.phoneNumber.isNotEmpty) {
    return Align(
        alignment: Alignment.center,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("tools").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShout) {
            if (snapShout.hasError)
              return new Text('Error: ${snapShout.error}');
            switch (snapShout.connectionState) {
              case ConnectionState.waiting:
                return new Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return Container(
                  height: 30,
                  child: ListView.builder(
                      itemCount: snapShout.data.docs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (snapShout.data.docs[1]["active_mode"] != true)
                                Center(
                                  child: Container(
                                    height: 60,
                                    width:
                                        MediaQuery.of(context).size.width - 70,
                                    color:
                                        HexColor('#f8f8ff').withOpacity(0.90),
                                    child: Center(
                                      child: Text(
                                        '${snapShout.data.docs[1]["title_free"]}',
                                        style: TextStyle(
                                            color: HexColor('#2c6bec'),
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                )
                              else
                                _userSub(context),
                            ],
                          ),
                        );
                      }),
                );
            }
          },
        ));
  } else {
    return Container();
  }
}

Widget _userSub(context) {
  int _cont = Provider.of<AccountProvider>(context).conter ;
  if (Provider.of<AccountProvider>(context, listen: false).sub1 == false &&
      Provider.of<AccountProvider>(context, listen: false).sub6 == false &&
      Provider.of<AccountProvider>(context, listen: false).sub12 == false) {
    return Row(
      children: [
        SizedBox(
          width: 5,
        ),
        Center(
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width - 70,
            color: HexColor('#f8f8ff').withOpacity(0.90),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'لديك $_cont رموز مجانى . للحصول على المزيد  ',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SharingScreen()));
                    },
                    child: Text(
                      'اشترك الان',
                      style: TextStyle(
                        color: Color(0xff2c6bec),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  } else {
    return Container();
  }
}
