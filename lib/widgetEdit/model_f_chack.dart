import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay/functions/save_code.dart';
import 'package:esay/models/offer_model.dart';
import 'package:esay/models/store_model.dart';
import 'package:esay/providers/auth_provider.dart';
import 'package:esay/providers/bottom_animation_provider.dart';
import 'package:esay/providers/code_provider.dart';
import 'package:esay/providers/loading_provider.dart';
import 'package:esay/widgets/code_offer.dart';
import 'package:esay/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:esay/providers/account_provider.dart';

class GetCodeEdit {
  static void check_sub(
      context, OfferModel offerModel, StoreModel storeModel) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final cIndexProvider = Provider.of<CIndexProvider>(context, listen: false);
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    loadingProvider.changeLoading(true);
    print(offerModel.id);
    await FirebaseFirestore.instance
        .collection("codes")
        .where("offerId", isEqualTo: offerModel.id)
        .where("user_id", isEqualTo: authProvider.userModel.phoneNumber)
        .get()
        .then((num) {
      print('here1');
      FirebaseFirestore.instance
          .collection("tools")
          .doc("PY08D3M4IAt4ipdiOE51")
          .get()
          .then((valueTools) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(authProvider.userModel.phoneNumber)
            .get()
            .then((subs) async {
          int count = num.docs.length.toInt();
          print(count);
          print(valueTools['active_mode']);
          print(subs['free_code']);
          if (valueTools['active_mode'] == false) {
            print("free");
            getCodeEasy(context, offerModel, storeModel);
          } else if (valueTools['active_mode'] == true &&
              count <= subs['free_code'] &&
              subs['free_code'] != 0) {
            print("free mode");
            getCodeEasy(context, offerModel, storeModel, free: 'free');
          } else if (subs["subscription1"] == true) {
            print("subscription1 true ");
            if (count <= subs["subscription_1"]) {
              print("subscription1");
              getCodeEasy(context, offerModel, storeModel);
            } else {
              dontHaveOfferCode(context);
            }
          } else if (subs["subscription6m"] == true) {
            if (count <= subs["subscription_6m"]) {
              print("subscription6m");
              getCodeEasy(context, offerModel, storeModel);
            } else {
              dontHaveOfferCode(context);
            }
          } else if (subs["subscription12m"] == true) {
            if (count <= subs["subscription_12m"]) {
              print("subscription12m");
              getCodeEasy(context, offerModel, storeModel,
                  fam12m: true,
                  fam: subs['family'],
                  phoneFam: subs['family_phone']);
            } else {
              dontHaveOfferCode(context);
            }
          } else {
            Navigator.of(context).pop();
            cIndexProvider.changeCIndex(3);
            cIndexProvider.changeNameNav("account");
            final newRouteName = "/sharingScreen";
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
          }
        });
      });
    });
  }

  static void getCodeEasy(context, OfferModel offerModel, StoreModel storeModel,
      {bool fam12m, bool fam, String phoneFam, String free}) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final codeProvider = Provider.of<CodeProvider>(context, listen: false);
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    try {
      String id = Random().nextInt(1000000).toString();
      print(id);
      if (free == null) {
        print("#3id");
        FirebaseFirestore.instance.collection("codes").doc().set({
          "code": id,
          "user_id": authProvider.userModel.phoneNumber,
          "offerId": offerModel.id,
          "storeId": offerModel.store,
          "dateTime": DateTime.now(),
          'free': false,
          'free_3': false,
          "endDateTime":
              DateTime.now().add(Duration(hours: offerModel.timeCode)),
          "cost": "0.0",
          "close": false,
        }).then((_) {
          GetCodeEdit.numCodeStack(
            offerModel.id,
          );
          String endDate = DateTime.now()
              .add(Duration(hours: offerModel.timeCode))
              .toString();
          addCode(context, id, storeModel.name, endDate);
          codeProvider.changeCode(id);
          loadingProvider.changeLoading(false);
          showDialog(
              context: context,
              builder: (context) {
                return CodeGetShow(code: id, time: offerModel.timeCode);
              });
          codeProvider.changeTimestamp(
              DateTime.now().add(Duration(hours: offerModel.timeCode)));
        }).then((_) {
          print("###########################");
          if (fam12m != null && fam == true) {
            print('fam12m');
            FirebaseFirestore.instance.collection("codes").doc().set({
              "close": true,
              "user_id": phoneFam,
              "offerId": offerModel.id,
              'free': false,
              'free_3': false,
              "storeId": offerModel.store,
              "dateTime": DateTime.now(),
              "endDateTime":
                  DateTime.now().add(Duration(hours: offerModel.timeCode)),
            });
          }
        }).catchError((e) {
          print(e);
        });
      } else {
        FirebaseFirestore.instance.collection("codes").doc().set({
          'free_3': true,
          'free': false,
          "code": id,
          "user_id": authProvider.userModel.phoneNumber,
          "offerId": offerModel.id,
          "storeId": offerModel.store,
          "dateTime": DateTime.now(),
          "endDateTime":
              DateTime.now().add(Duration(hours: offerModel.timeCode)),
          "cost": "0.0",
          "close": false,
        }).then((_) {
          GetCodeEdit.numCodeStack(
            offerModel.id,
          );
          String endDate = DateTime.now()
              .add(Duration(hours: offerModel.timeCode))
              .toString();
          addCode(context, id, storeModel.name, endDate);
          codeProvider.changeCode(id);
          loadingProvider.changeLoading(false);
          showDialog(
              context: context,
              builder: (context) {
                return CodeGetShow(code: id, time: offerModel.timeCode);
              });
          codeProvider.changeTimestamp(
              DateTime.now().add(Duration(hours: offerModel.timeCode)));
        }).then((_) async {
          await FirebaseFirestore.instance
              .collection('codes')
              .where('user_id', isEqualTo: authProvider.userModel.phoneNumber)
              .where('free_3', isEqualTo: true)
              .get()
              .then((code) {
            print("code.docs.length${code.docs.length}");
            FirebaseFirestore.instance
                .collection('users')
                .doc(authProvider.userModel.phoneNumber)
                .get()
                .then((use) {
              int usXod = use['free_code'] - 1;
              int xx = usXod < 0 ? 0 : usXod;
              print(xx);
              // if (code.docs.length <= 3) {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(authProvider.userModel.phoneNumber)
                  .update({
                'free_code': xx,
              }).then((_) {
                String codeEa = Random().nextInt(1000000).toString();
                Provider.of<AccountProvider>(context, listen: false)
                    .contr(use['free_code']);
                if (usXod <= 0) {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(authProvider.userModel.phoneNumber)
                      .update({
                    'notifications_check': false,
                    'notf': DateTime.now().add(Duration(hours: 72)),
                    'codeEasy': codeEa,
                  });
                }
              });
              // }
            });
          });
        });
      }
    } catch (e) {
      print(e.print);
    }
  }

  static Future<void> numCodeStack(String id) async {
    FirebaseFirestore.instance.collection('offers').doc(id).get().then((value) {
      int _x = value['numCodesTaken'] + 1;
      FirebaseFirestore.instance.collection('offers').doc(id).update({
        'numCodesTaken': _x,
      });
    });
  }
}
