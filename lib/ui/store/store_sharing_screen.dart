import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay/models/store_model.dart';
import 'package:esay/providers/loading_provider.dart';
import 'package:esay/providers/store_provider.dart';
import 'package:esay/services/firestore_database.dart';
import 'package:esay/widgets/loading.dart';
import 'package:esay/widgets/validate_phone.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';

class StoreSharingScreen extends StatefulWidget {
  StoreSharingScreen({this.storeModel, this.scaffoldKey});
  final StoreModel storeModel;
  final scaffoldKey;
  @override
  _StoreSharingScreenState createState() => _StoreSharingScreenState();
}

class _StoreSharingScreenState extends State<StoreSharingScreen> {
  TextEditingController _codeStoreController = TextEditingController(text: "");
  TextEditingController _phoneController;
  String countryCode = "+970";
  int tab = 1;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _phoneFocus = FocusNode();

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
    return Form(
        key: _formKey,
        child: ListView(children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              AppLocalizations.of(context).translate('storeShare1'),
              style: TextStyle(
                  fontSize: 17,
                  color: HexColor("#49494a"),
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: Text(
              AppLocalizations.of(context).translate('storeShare2'),
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.blueGrey[500],
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 30),
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
                        focusNode: _phoneFocus,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(9),
                        ],
                        validator: (value) {
                          if (value.isEmpty || value.length < 9) {
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
                            borderSide:
                                BorderSide(width: 1, color: Colors.blue),
                          ),
                          hintStyle:
                              TextStyle(color: Colors.grey, letterSpacing: 0.5),
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
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        value: "+970",
                      ),
                      DropdownMenuItem(
                        child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text("+972",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        value: "+972",
                      ),
                      // DropdownMenuItem(
                      //   child: Directionality(
                      //       textDirection: TextDirection.ltr,
                      //       child: Text("+20",
                      //           style: TextStyle(fontWeight: FontWeight.bold))),
                      //   value: "+2",
                      // ),
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
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              AppLocalizations.of(context).translate('storeShare3'),
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.blueGrey[500],
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('subscription')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            tab = 159427047;
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 90,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[50],
                              border: Border.all(
                                  width: 2,
                                  color: tab == 1
                                      ? Colors.blue
                                      : Colors.grey[600]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "12 شهر",
                                  style: TextStyle(fontSize: 22),
                                ),
                                Text(
                                  "${snapshot.data.docs[0]['12month']} شيكل ",
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_codeStoreController.text.isNotEmpty) {
                            _codeStoreController.clear();
                          }
                          setState(() {
                            tab = 2;
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 90,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[50],
                              border: Border.all(
                                  width: 2,
                                  color: tab == 2
                                      ? Colors.blue
                                      : Colors.grey[600]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "6 شهر",
                                style: TextStyle(fontSize: 22),
                              ),
                              Text(
                                "${snapshot.data.docs[0]['6month']} شيكل",
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_codeStoreController.text.isNotEmpty) {
                            _codeStoreController.clear();
                          }
                          setState(() {
                            tab = 3;
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 90,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[50],
                              border: Border.all(
                                  width: 2,
                                  color: tab == 3
                                      ? Colors.blue
                                      : Colors.grey[600]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "1 شهر",
                                style: TextStyle(fontSize: 22),
                              ),
                              Text(
                                "${snapshot.data.docs[0]['1month']} شيكل",
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 32),
            child: Text(
              AppLocalizations.of(context).translate('storeShare4'),
              style: TextStyle(
                fontSize: 17,
                color: Colors.blueGrey[500],
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Center(
            child: Text(
              AppLocalizations.of(context).translate('storeShare5'),
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.blueGrey[500],
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Theme(
                    data: ThemeData(primaryColor: Colors.blue),
                    child: TextField(
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.blueGrey[200],
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5),
                      keyboardType: TextInputType.number,
                      enabled: tab == 1 ? true : false,
                      controller: _codeStoreController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)
                                .translate('storeShare6') +
                            " "
                                "Enter the code",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.blue),
                        ),
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[100]),
                      ),
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              Container(
                  child: Image.asset(
                "assets/images/key.png",
                color: HexColor('#2c6bec'),
                width: 35,
              )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Center(
                child: Column(children: [
              SizedBox(
                height: 5,
              ),
              Text(AppLocalizations.of(context).translate('storeShare7'),
                  style: TextStyle(
                    color: Colors.blueGrey[500],
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child:
                    Text(AppLocalizations.of(context).translate('storeShare8'),
                        style: TextStyle(
                          color: Colors.blueGrey[500],
                        )),
              )
            ])),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3.5,
                  vertical: MediaQuery.of(context).size.width / 14),
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 12),
              decoration: BoxDecoration(
                  color: HexColor('#2c6bec'),
                  borderRadius: BorderRadius.circular(35)),
              child: Consumer<LoadingProvider>(
                  builder: (context, loadingProvider, _) {
                return loadingProvider.getLoading
                    ? Container(height: 48, child: loadingBtn(context))
                    : FlatButton(
                        onPressed: () async {
                          final storePovider =
                              Provider.of<StorePovider>(context, listen: false);
                          if (_formKey.currentState.validate()) {
                            _phoneFocus.unfocus();
                            String phone = countryCode + _phoneController.text;
                            double calc;
                            double easyCost;
                            if (tab == 1) {
                              calc = 150.0 - 5.0;
                              easyCost = storePovider.getEasyCost + calc;
                            } else if (tab == 2) {
                              calc = 110.0 - 3.0;
                              easyCost = storePovider.getEasyCost + calc;
                            } else {
                              calc = 20.0 - 2.0;
                              easyCost = storePovider.getEasyCost + calc;
                            }
                            String code = _codeStoreController.text;
                            int days = tab == 1
                                ? 360
                                : tab == 2
                                    ? 180
                                    : 30;
                            validatePhone(
                                context,
                                code,
                                phone,
                                widget.storeModel.id,
                                days,
                                calc,
                                easyCost.toStringAsFixed(1),
                                widget.scaffoldKey,
                                widget.storeModel.name);

                            _phoneController.clear();
                            _codeStoreController.clear();
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context).translate('storeShare9'),
                          style: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ));
              })),
        ]));
  }
}
