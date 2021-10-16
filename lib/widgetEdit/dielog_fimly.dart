import 'dart:ui';
import 'package:esay/widgetEdit/custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:esay/widgetEdit/test.dart';
import '../app_localizations.dart';
import 'package:esay/widgets/show_toast.dart';



class FaimlyCode extends StatefulWidget {
  final String title, descriptions, text, code;
  final Image img;

  FaimlyCode(
      {Key key, this.title, this.descriptions, this.text, this.img, this.code})
      : super(key: key);

  @override
  _FaimlyCodeState createState() => _FaimlyCodeState();
}

class _FaimlyCodeState extends State<FaimlyCode> {
  String countryCode = "+970";
  TextEditingController _phoneController;
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      alignment: Alignment.center,
      height: 310,
      width: 350,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade50,
      ),
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
          SizedBox(height: 10,),
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
                          LengthLimitingTextInputFormatter(9),
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
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.center,
                height: 40,
                width: 70,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text(
                    "الغاء",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
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
    );
  }
}
