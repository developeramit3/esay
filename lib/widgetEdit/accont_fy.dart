import 'package:esay/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../app_localizations.dart';

class AccountFimPhone extends StatefulWidget {
  @override
  _AccountFimPhoneState createState() => _AccountFimPhoneState();
}

class _AccountFimPhoneState extends State<AccountFimPhone> {
  TextEditingController _phoneController;

  String countryCode = "+970";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          elevation: 0,
          title: Text(
            "حسابي",
            style: TextStyle(color: Colors.black, fontSize: 26),
          ),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              box30,
              box30,
              Text(
                "الوقت المتبقي على الاشتراك",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              box20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "164",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    "يوم",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                "اضافة فرد من العاىْلة",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              ),
              box,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, size: 35, color: Colors.orange),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "من اول 100 مشترك في التطبيق",
                    style: TextStyle(color: Colors.orangeAccent, fontSize: 19),
                  ),
                ],
              ),
              box,
              SizedBox(height: 30),
              Container(
                alignment: Alignment.center,
                height: 300,
                width: 300,
                padding: EdgeInsets.all(10),
                color: Colors.grey.shade100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اضافة فرد من العاىْلة",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w900),
                    ),
                    box,
                    Text(
                      'ملاحظه: لا يمكن تغير الرقم الضغط على تاكيد',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Theme(
                                data: ThemeData(primaryColor: Colors.blue),
                                child: TextFormField(
                                  textAlign: TextAlign.end,
                                  controller: _phoneController,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(11),
                                  ],
                                  validator: (value) {
                                    if (value.isEmpty || value.length < 11) {
                                      return AppLocalizations.of(context)
                                          .translate('phoneError');
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                      color: Colors.grey,
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
                                        color: Colors.grey, letterSpacing: 0.5),
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
                                              fontWeight: FontWeight.bold))),
                                  value: "+970",
                                ),
                                DropdownMenuItem(
                                  child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Text("+972",
                                          style: TextStyle(
                                            color: Colors.black,
                                              fontWeight: FontWeight.w900))),
                                  value: "+972",
                                ),
                                DropdownMenuItem(
                                  child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Text("+20",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))),
                                  value: "+2",
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  countryCode = value;
                                });
                              }),
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
                        Container(
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
                      ],
                    )
                  ],
                ),
              ),
            ])));
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
}
