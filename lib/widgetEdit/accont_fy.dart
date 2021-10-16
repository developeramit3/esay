import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:esay/widgetEdit/test.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import '../app_localizations.dart';
import 'package:esay/widgets/show_toast.dart';
import 'package:provider/provider.dart';
import 'package:esay/providers/account_provider.dart';
class AccountFimPhone extends StatefulWidget {
  final String authNumber;

  const AccountFimPhone({Key key, this.authNumber}) : super(key: key);
  @override
  _AccountFimPhoneState createState() => _AccountFimPhoneState();
}

class _AccountFimPhoneState extends State<AccountFimPhone> {
  TextEditingController _phoneController;
  String countryCode = "+970";
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          elevation: 0,
          title: Text(
            "حسابي",
            style: TextStyle(
                color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget12m(widget.authNumber),
                  SizedBox(
                    height: 30,
                  ),
                  box,
                  Provider.of<AccountProvider>(context,listen: false).userSize <= 150 ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, size: 35, color: Colors.orange),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        " من اول 100 مشترك في التطبيق !",
                        style:
                            TextStyle(color: Colors.orangeAccent, fontSize: 19),
                      ),
                    ],
                  ):Container(),
                  box,
                  SizedBox(height: 30),
                  Container(
                    alignment: Alignment.center,
                    height: 290,
                    width: 325,
                    padding: EdgeInsets.all(10),
                    color: Colors.grey.shade50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "إضافة فرد من العائلة",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w900),
                        ),
                        box,
                        Text(
                          'ملاحظة: لا يمكنك تغيير الرقم بعد الضغط \n على تأكيد',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Theme(
                                    data: ThemeData(primaryColor: Colors.blue),
                                    child: TextFormField(
                                      textAlign: TextAlign.end,
                                      controller: _phoneController,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(11),
                                      ],
                                      validator: (value) {
                                        if (value.isEmpty ||
                                            value.length < 11) {
                                          return AppLocalizations.of(context)
                                              .translate('phoneError');
                                        }
                                        return null;
                                      },
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(context)
                                            .translate("123456789"),
                                        contentPadding: EdgeInsets.all(0.0),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.blue),
                                        ),
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            letterSpacing: 0.5),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(width: 12),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: DropdownButton(
                                  value: countryCode,
                                  underline: Container(),
                                  items: [
                                    DropdownMenuItem(
                                      child: Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Text("+970",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      value: "+970",
                                    ),
                                    DropdownMenuItem(
                                      child: Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Text("+972",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.w900))),
                                      value: "+972",
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      countryCode = value;
                                    });
                                  }),
                            ),
                            SizedBox(width: 12),
                            Image.asset(
                              'assets/images/phone 2nd.png',
                              width: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        box20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 70,
                              child: Text(
                                "الغاء",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                if (_phoneController.text.isNotEmpty) {
                                  String phone =
                                      countryCode + _phoneController.text;
                                  SetNot.setFamily(context, phone);
                                  _phoneController.clear();
                                } else {
                                  showToast(
                                      "phoneNumberEmpty", Colors.red, context);
                                  _phoneController.clear();
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 70,
                                color: Colors.blue,
                                child: Text(
                                  "تاكيد",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ]),
          ),
        )));
  }

  SizedBox get box => SizedBox(
        height: 10,
      );
  SizedBox get box20 => SizedBox(
        height: 20,
      );
  SizedBox get box30 => SizedBox(
        height: 30,
      );
  Widget widget12m(String phone) {
    return Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('sharing_users')
            .where("phoneNumber", isEqualTo: phone)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        "الوقت المتبقي للاشتراك",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                          children: snapshot.data.docs.map((e) {
                        int endTime =
                            e.data()/*["endDateTime"].millisecondsSinceEpoch +
                                1000 * 30*/;
                        return CountdownTimer(
                          endTime: endTime,
                          widgetBuilder: (_, CurrentRemainingTime time) {
                            return Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  time.days.toString() + " " + "يوم",
                                  style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.bold),
                                ));
                          },
                        );
                      }).toList()),
                    ]))
                  : Container(
                      height: 150,
                    );
          }
        },
      ),
      SizedBox(
        height: 60,
      ),
      Text(
        "اضافة فرد من العاىْلة",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w900, fontSize: 20),
      ),
    ]));
  }
}
