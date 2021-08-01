import 'package:esay/models/store_model.dart';
import 'package:esay/providers/loading_provider.dart';
import 'package:esay/services/firestore_database.dart';
import 'package:esay/widgets/loading.dart';
import 'package:esay/widgets/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';
import '../../widgets/appbar.dart';

class LoginStoreScreen extends StatefulWidget {
  @override
  _LoginStoreScreenState createState() => _LoginStoreScreenState();
}

class _LoginStoreScreenState extends State<LoginStoreScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Home", showBack: true),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 70),
              child: Text(
               "هذه الصفحة خاصة فقط بالمحلات المسجلة لدينا مسبقا، تواصلوا معنا لتصيرو جزء من عيلتنا!",
                style: TextStyle(
                    fontSize: 17,
                    color: HexColor("#49494a"),
                    fontWeight: FontWeight.bold),
              ),
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
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5),
                        keyboardType: TextInputType.name,
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: "Enter store name",
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.blue),
                          ),
                          hintStyle: TextStyle(
                              color: Colors.blueGrey[100], letterSpacing: 0.5),
                        ),
                      ),
                    )),
                SizedBox(width: 10),
                Container(
                    child: Image.asset(
                  "assets/images/branch blue.png",
                  color: Colors.blue[300],
                  width: 35,
                )),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Theme(
                        data: ThemeData(primaryColor: Colors.blue),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6),
                            ],
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5),
                            keyboardType: TextInputType.name,
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: "Enter password",
                              contentPadding: EdgeInsets.all(0.0),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.blue),
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.blueGrey[100],
                                  letterSpacing: 0.5),
                            ),
                          ),
                        ))),
                SizedBox(width: 10),
                Container(
                    child: Image.asset(
                  "assets/images/lock.png",
                  color: Colors.blue[300],
                  width: 35,
                )),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                  color: HexColor('#2c6bec'),
                  borderRadius: BorderRadius.circular(35)),
              child: FlatButton(
                child: Consumer<LoadingProvider>(
                    builder: (context, loadingProvider, _) {
                  return loadingProvider.getLoading
                      ? loadingBtn(context)
                      : Text(
                          AppLocalizations.of(context).translate('LoginStore'),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        );
                }),
                onPressed: () async {
                  if (_nameController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    final firestoreDatabase =
                        Provider.of<FirestoreDatabase>(context, listen: false);
                    StoreModel storeModel = StoreModel(
                        name: _nameController.text,
                        password: _passwordController.text);
                    await firestoreDatabase.loginStore(context, storeModel);
                  } else {
                    showToast("name or password is empty", Colors.red, context,
                        center: true);
                  }
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
