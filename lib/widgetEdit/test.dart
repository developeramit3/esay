import 'dart:math';
import 'package:esay/models/offer_model.dart';
import 'package:esay/services/firestore_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay/functions/save_code.dart';
import 'package:esay/providers/account_provider.dart';
import 'package:esay/providers/auth_provider.dart';
import 'package:esay/providers/code_provider.dart';
import 'package:esay/widgets/code_offer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:esay/widgets/show_toast.dart';
import 'package:esay/providers/loading_provider.dart';

class SetNot {
  static Future<void> setNot(context) async {
    final _firebase = FirebaseFirestore.instance;
    await _firebase
        .collection("users")
        .where("free_code", isEqualTo: 0)
        .where("subscription1", isEqualTo: false)
        .where("notifications_check", isEqualTo: false)
        .where("subscription6m", isEqualTo: false)
        .where("subscription12m", isEqualTo: false)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element["notf"].toDate().isAfter(DateTime.now())) {
        } else {
          _firebase.collection('notices72').doc().set({
            'subtitle': "subtitle",
            'title': "title",
            'token': element['tokenId'],
          }).then((_) {
            _firebase.collection('users').doc(element.id).update({
              'notifications_check': true,
            });
          });
        }
      });
    });
  }

  static Future<void> getDataUsers(context) async {
    print("here");
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("here2");
    await FirebaseFirestore.instance
        .collection('tools')
        .doc('PY08D3M4IAt4ipdiOE51')
        .get()
        .then((valueUs) {
      Provider.of<AccountProvider>(context, listen: false)
          .refresh(valueUs['refresh']);
      Provider.of<AccountProvider>(context, listen: false)
          .toolsTrue(valueUs['active_mode']);
      prefs.setBool('mode', valueUs['active_mode']);
      print("here is good ${prefs.getBool('mode')}");
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(authProvider.userModel.phoneNumber)
          .get()
          .then((value) {
        Provider.of<AccountProvider>(context, listen: false).getSubUser(
          value['subscription1'],
          value['subscription6m'],
          value['subscription12m'],
        );
        Provider.of<AccountProvider>(context, listen: false)
            .contr(value['free_code']);
      });
    });
  }

////////////////////////// setFamily ///////////////////////////
  static Future<void> setFamily(context, String phone) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final _firebase = FirebaseFirestore.instance;
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    loadingProvider.changeLoading(true);
    final querySnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(authProvider.userModel.phoneNumber)
        .get();
    final querySnapshot =
        await FirebaseFirestore.instance.collection('users').doc(phone).get();
    if (querySnap['family'] == false) {
      if (querySnapshot.exists) {
        _firebase
            .collection("users")
            .doc(authProvider.userModel.phoneNumber)
            .update({
          "family": true,
          "family_phone": phone,
        }).then((_) {
          _firebase.collection("users").doc(phone).update({
            "subscription12m": true,
            "family": true,
            "f_phone": authProvider.userModel.phoneNumber,
          }).then((_) {
            _firebase
                .collection("sharing_users")
                .doc(authProvider.userModel.phoneNumber)
                .update({
              "family": true,
              "family_phone": phone,
            });
          });
        });
        showToaSec(context, center: true);
        loadingProvider.changeLoading(false);
      } else {
        loadingProvider.changeLoading(false);
        showToast("This user is not exist, register", Colors.red, context,
            center: true);
      }
    }
    showToaCheck(context);
  }

  static Future<void> ctogryNumber(context) async {
    await Firestore.instance
        .collection('offers_category')
        .get()
        .then((valueCat) {
      Provider.of<AccountProvider>(context, listen: false)
          .checkNul(valueCat.docs.length);
      print(
          "catog${Provider.of<AccountProvider>(context, listen: false).checkNull}");
    });
  }

  //////////////////////////////

  static Future<void> easyDis(context, var time) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final codeProvider = Provider.of<CodeProvider>(context, listen: false);
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    String id = Random().nextInt(1000000).toString();
    Firestore.instance.collection('easyDis').doc().set({
      'code': id,
      'phoneNumber': authProvider.userModel.phoneNumber,
    }).then((value) {
      String endDate = DateTime.now().add(Duration(hours: time)).toString();
      addCode(context, id, "ease", endDate);
      codeProvider.changeCode(id);
      loadingProvider.changeLoading(false);
      showCodeDialog(context, id, time);
      codeProvider.changeTimestamp(DateTime.now().add(Duration(hours: time)));
    });
  }

  static Future<void> getCodeDetail(
      BuildContext context, OfferModel offerModel) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final codeProvider = Provider.of<CodeProvider>(context, listen: false);
    codeProvider.changeCode("");
    codeProvider.changeTimestamp(DateTime.now());
    if (authProvider.userModel.phoneNumber != "") {
      final documentReference2 = await Firestore.instance
          .collection(FirestorePath.getCodes())
          .where('userId', isEqualTo: authProvider.userModel.phoneNumber)
          .where('offerId', isEqualTo: offerModel.id)
          .where('close', isEqualTo: false)
          .get();
      if (documentReference2.size != 0) {
        documentReference2.docs.map((e) {
          if (e["endDateTime"].toDate().isAfter(DateTime.now())) {
            codeProvider.changeCode(e["code"]);
            codeProvider.changeTimestamp(e["endDateTime"].toDate());
          }
        }).toList();
      }
    }
  }
}
