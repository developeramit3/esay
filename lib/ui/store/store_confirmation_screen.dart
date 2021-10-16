import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay/caches/sharedpref/shared_preference_helper.dart';
import 'package:esay/models/store_model.dart';
import 'package:esay/providers/bottom_animation_provider.dart';
import 'package:esay/providers/code_provider.dart';
import 'package:esay/providers/loading_provider.dart';
import 'package:esay/services/firestore_database.dart';
import 'package:esay/widgets/loading.dart';
import 'package:esay/widgets/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class StoreConfirmationScreen extends StatefulWidget {
  StoreConfirmationScreen({this.storeModel});
  final StoreModel storeModel;
  @override
  _StoreConfirmationScreenState createState() =>
      _StoreConfirmationScreenState();
}

class _StoreConfirmationScreenState extends State<StoreConfirmationScreen> {
  TextEditingController _codeController = TextEditingController(text: "");
  TextEditingController _beforOfferController = TextEditingController(text: "");
  TextEditingController _afterOfferController = TextEditingController(text: "");
  String code;

  @override
  Widget build(BuildContext context) {
    final codeProvider = Provider.of<CodeProvider>(context, listen: false);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('stores')
            .where('password', isEqualTo: widget.storeModel.password)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              List data = snapshot.data.docs;
              return ListView(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: AppLocalizations.of(context)
                                .translate('storeConfirmationNote'),
                            style: TextStyle(
                                fontSize: 15,
                                color: HexColor("#49494a"),
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: " "),
                          TextSpan(
                            text: AppLocalizations.of(context)
                                .translate('storeExtraConfirmationNote'),
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Theme(
                            data: ThemeData(primaryColor: Colors.blue),
                            child: TextField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6),
                              ],
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                              keyboardType: TextInputType.number,
                              controller: _codeController,
                              decoration: InputDecoration(
                                icon: InkWell(
                                    child: Image.asset(
                                      'assets/images/QR scan.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                    onTap: () async {
                                      try {
                                       /* final qrCode =
                                            await FlutterBarcodeScanner
                                                .scanBarcode(
                                          '#ff6666',
                                          'Cancel',
                                          true,
                                          ScanMode.QR,
                                        );*/
                                        if (!mounted) return;
                                        setState(() {
                                          // code = qrCode;
                                          // _codeController.text = qrCode;
                                        });
                                        if (_codeController.text.isNotEmpty) {
                                          print(
                                              "this is sore id ${widget.storeModel.id}");
                                          final firestoreDatabase =
                                              Provider.of<FirestoreDatabase>(
                                                  context,
                                                  listen: false);
                                          await firestoreDatabase.checkCode(
                                              context,
                                              widget.storeModel.id,
                                              _codeController.text);
                                        }
                                      } on PlatformException {
                                        code =
                                            'Failed to get platform version.';
                                      }
                                    }),
                                hintText: "Enter the code",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.blue),
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
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 4,
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
                                  if (_codeController.text.isNotEmpty) {
                                    print(
                                        "this is sore id ${widget.storeModel.id}");
                                    final firestoreDatabase =
                                        Provider.of<FirestoreDatabase>(context,
                                            listen: false);
                                    await firestoreDatabase.checkCode(
                                        context,
                                        widget.storeModel.id,
                                        _codeController.text);
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('check'),
                                  style: TextStyle(
                                      fontSize: 26,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ));
                      })),
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
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                              keyboardType: TextInputType.number,
                              controller: _beforOfferController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                hintText: AppLocalizations.of(context)
                                    .translate("beforMoney"),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.blue),
                                ),
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey[100]),
                              ),
                            ),
                          )),
                      SizedBox(width: 20),
                      Container(
                          child: Image.asset(
                        "assets/images/coins.png",
                        color: HexColor('#2c6bec'),
                        width: 35,
                      )),
                    ],
                  ),
                  SizedBox(height: 20),
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
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                              keyboardType: TextInputType.number,
                              controller: _afterOfferController,
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)
                                    .translate("afterMoney"),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.blue),
                                ),
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey[100]),
                              ),
                            ),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          child: Image.asset(
                        "assets/images/coins.png",
                        color: HexColor('#2c6bec'),
                        width: 35,
                      )),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 4,
                        vertical: MediaQuery.of(context).size.width / 14),
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 12),
                    decoration: BoxDecoration(
                        color: HexColor('#2c6bec'),
                        borderRadius: BorderRadius.circular(35)),
                    child: Consumer<LoadingProvider>(
                        builder: (context, loadingProvider, _) {
                      return loadingProvider.getLoading1
                          ? Container(height: 48, child: loadingBtn(context))
                          : FlatButton(
                              minWidth: 150,
                              onPressed: () async {
                                if (codeProvider.getCodeId.isNotEmpty) {
                                  if (int.parse(_afterOfferController.text) <
                                      int.parse(_beforOfferController.text)) {
                                    final firestoreDatabase =
                                        Provider.of<FirestoreDatabase>(context,
                                            listen: false);
                                    double cost = double.parse(
                                            _beforOfferController.text) -
                                        double.parse(
                                            _afterOfferController.text);
                                    double total =
                                        (double.parse(data[0]["total"]) +
                                            double.parse(
                                                _afterOfferController.text));
                                    double totalNow =
                                        (double.parse(data[0]["totalNow"]) +
                                            double.parse(
                                                _afterOfferController.text));
                                    String customer =
                                        (int.parse(data[0]["customers"]) + 1)
                                            .toString();
                                    String customerNow =
                                        (int.parse(data[0]["customersNow"]) + 1)
                                            .toString();
                                    await firestoreDatabase.calcOffer(
                                        context,
                                        widget.storeModel.password,
                                        _codeController.text,
                                        cost.toStringAsFixed(1),
                                        total.toStringAsFixed(1),
                                        totalNow.toStringAsFixed(1),
                                        customer,
                                        customerNow);
                                    _codeController.clear();
                                    _beforOfferController.clear();
                                    _afterOfferController.clear();
                                  }else{
                                    showToast(
                                        "errorOfferCalc", Colors.red, context);
                                  }
                                } else {
                                  showToast(
                                      "errorOfferCalc", Colors.red, context);
                                }
                              },
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('confirm'),
                                style: TextStyle(
                                    fontSize: 26,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ));
                    }),
                  ),
                  gridViewWidget(data[0]["total"], data[0]["totalNow"],
                      data[0]["customers"], data[0]["customersNow"]),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                color: HexColor('#f8f8ff').withOpacity(0.90),
                                borderRadius: BorderRadius.circular(30)),
                            child: FlatButton.icon(
                              onPressed: () {
                                SharedPreferenceHelper().removeStorePrefs();
                                final cIndexProvider =
                                    Provider.of<CIndexProvider>(context,
                                        listen: false);
                                cIndexProvider.changeCIndex(0);
                                cIndexProvider.changeNameNav("home");
                                final newRouteName = "/homeScreen";
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
                              label: Text(
                                AppLocalizations.of(context)
                                    .translate('logout'),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              icon: Image.asset(
                                'assets/images/out.png',
                                fit: BoxFit.fitHeight,
                                width: 25,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                color: HexColor('#2c6bec').withOpacity(0.90),
                                borderRadius: BorderRadius.circular(30)),
                            child: FlatButton(
                                onPressed: () async {
                                  final firestoreDatabase =
                                      Provider.of<FirestoreDatabase>(context,
                                          listen: false);
                                  await firestoreDatabase.calcDiscountEasy(
                                      context,
                                      data[0]["totalNow"],
                                      data[0]["discount"],
                                      data[0]["easyCost"]);
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('calculateTotalEasyPrice'),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
          }
        });
  }

  Widget gridViewWidget(
      String total, String totalNow, String customer, String customerNow) {
    return Container(
      padding: EdgeInsets.all(40),
      height: 280,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: 1.5,
        crossAxisCount: 2,
        crossAxisSpacing: 50,
        mainAxisSpacing: 16,
        children: [
          Card(
            color: HexColor('#2c6bec'),
            child: GridTile(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('totalNow'),
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    totalNow,
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: HexColor('#2c6bec'),
            child: GridTile(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('customerNow'),
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    customerNow,
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: HexColor('#2c6bec'),
            child: GridTile(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('total'),
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    total,
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: HexColor('#2c6bec'),
            child: GridTile(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('customer'),
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    customer,
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
