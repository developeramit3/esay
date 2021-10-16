import 'dart:math';
import 'package:esay/models/offer_model.dart';
import 'package:esay/services/firestore_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay/functions/save_code.dart';
import 'package:esay/providers/account_provider.dart';
import 'package:esay/providers/auth_provider.dart';
import 'package:esay/providers/code_provider.dart';
import 'package:esay/ui/sharing/sharing_screen.dart';
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
        if (element["notf"]
            .toDate()
            .isAfter(DateTime.now().add(Duration(hours: 71)))) {
        } else {
          _firebase.collection('notices72').doc().set({
            'subtitle':
                " لمدة 72 ساعة فقط، اكسب خصم 50 شيكل، وخلي توفيراتك تصير بالألوف!",
            'title': " خصم على اشتراك إيزي السنوي لفترة محدودة! 😎😍",
            'token': element['tokenId'],
          }).then((_) {
            _firebase.collection('users').doc(element.id).update({
              'notifications_check': true,
              'notifications_check24': false,
            });
          });
        }
      });
    });
  }

  static Future<void> setNot24(context) async {
    final _firebase = FirebaseFirestore.instance;
    await _firebase
        .collection("users")
        .where("free_code", isEqualTo: 0)
        .where("subscription1", isEqualTo: false)
        .where("notifications_check24", isEqualTo: false)
        .where("subscription6m", isEqualTo: false)
        .where("subscription12m", isEqualTo: false)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element["notf"]
            .toDate()
            .isAfter(DateTime.now().add(Duration(hours: 24)))) {
        } else {
          _firebase.collection('notices72').doc().set({
            'subtitle':
                "شو بتستنى؟ باقي أقل من 24 ساعة على الخصم وخلص بروح عليك بح!",
            'title': " لسا ما اشتركت في إيزي؟ 😱",
            'token': element['tokenId'],
          }).then((_) {
            _firebase.collection('users').doc(element.id).update({
              'notifications_check': true,
              'notifications_check24': true,
            });
          });
        }
      });
    });
  }

  static Future<void> getDataUsers(context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await FirebaseFirestore.instance
          .collection('tools')
          .doc('PY08D3M4IAt4ipdiOE51')
          .get()
          .then((valueUs) {
        Provider.of<AccountProvider>(context, listen: false)
            .refresh(valueUs['refresh']);
        Provider.of<AccountProvider>(context, listen: false)
            .toolsTrue(valueUs['active_mode']);
        Provider.of<AccountProvider>(context, listen: false)
            .offerS(valueUs['offer_sc']);
        prefs.setBool('mode', valueUs['active_mode']);
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
    } catch (e) {}
  }

////////////////////////// setFamily ///////////////////////////
  static Future<void> setFamily(context, String phone) async {
    try {
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
              'fff': true,
              "family_phone": authProvider.userModel.phoneNumber,
              'free_code': 0,
            }).then((_) async {
              final _firebase = FirebaseFirestore.instance;
              await _firebase
                  .collection("codes")
                  .where("user_id", isEqualTo: phone)
                  .get()
                  .then((value) {
                value.docs.forEach((element) {
                  _firebase.collection('codes').doc(element.id).delete();
                });
              }).then((value) {
                _firebase
                    .collection("sharing_users")
                    .doc(authProvider.userModel.phoneNumber)
                    .update({
                  "family": true,
                  "family_phone": phone,
                }).then((value) async {
                  final _firebase = FirebaseFirestore.instance;
                  await _firebase
                      .collection("codes")
                      .where("user_id", isEqualTo: phone)
                      .get()
                      .then((value) {
                    value.docs.forEach((element) {
                      _firebase.collection('codes').doc(element.id).delete();
                    }); //562 940 853
                  }).then((value) async {
                    final _firebase = FirebaseFirestore.instance;
                    await _firebase
                        .collection("codes")
                        .where("user_id",
                            isEqualTo: authProvider.userModel.phoneNumber)
                        .get()
                        .then((value) {
                      value.docs.forEach((element) {
                        _firebase.collection('codes').doc().set({
                          'close': true,
                          'free': false,
                          'user_id': phone,
                          'free_3': false,
                          'offerId': element['offerId'],
                        });
                      });
                    });
                  });
                });
              });
            }).then((value) {
              showToaSec(context, center: true);
              loadingProvider.changeLoading(false);
            });
          });
        } else {
          loadingProvider.changeLoading(false);
          showToast("This user is not exist, register", Colors.red, context,
              center: true);
        }
      } else {
        showToaCheck(context);
        loadingProvider.changeLoading(false);
      }
    } catch (e) {}
  }

  static Future<void> ctogryNumber(context) async {
    try {
      await FirebaseFirestore.instance
          .collection('offers_category')
          .get()
          .then((valueCat) {
        Provider.of<AccountProvider>(context, listen: false)
            .checkNul(valueCat.docs.length);
      });
    } catch (e) {}
  }

  //////////////////////////////
  static Future<void> easyDis(context, var time) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final codeProvider = Provider.of<CodeProvider>(context, listen: false);
      final loadingProvider =
          Provider.of<LoadingProvider>(context, listen: false);
      String id = Random().nextInt(1000000).toString();
      FirebaseFirestore.instance.collection('easyDis').doc().set({
        'code': id,
        'phoneNumber': authProvider.userModel.phoneNumber,
      }).then((value) {
        String endDate = DateTime.now().add(Duration(hours: time)).toString();
        addCode(context, id, "ease", endDate);
        codeProvider.changeCode(id);
        loadingProvider.changeLoading(false);
        showDialog(
            context: context,
            builder: (context) {
              return CodeGetShow(code: id, time: time);
            });
        codeProvider.changeTimestamp(DateTime.now().add(Duration(hours: time)));
      });
    } catch (e) {}
  }

  static Future<void> getCodeDetail(BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final codeProvider = Provider.of<CodeProvider>(context, listen: false);
      codeProvider.changeCode("");
      codeProvider.changeTimestamp(DateTime.now());
      if (authProvider.userModel.phoneNumber != "") {
        final documentReference2 = await FirebaseFirestore.instance
            .collection(FirestorePath.getCodes())
            .where('user_id', isEqualTo: authProvider.userModel.phoneNumber)
            .where('close', isEqualTo: false)
            .get();
        if (documentReference2.size != 0) {
          documentReference2.docs.map((e) async {
            if (e["endDateTime"].toDate().isAfter(DateTime.now())) {
              // codeProvider.changeCode(e["code"]);
              // codeProvider.changeTimestamp(e["endDateTime"].toDate());
            } else {
              FirebaseFirestore.instance
                  .collection('codes')
                  .doc(e.id)
                  .delete()
                  .then((value) => print('sssssFFuke'));
            }
          }).toList();
        }
      }
    } catch (e) {}
  }

  static Future<void> getCodeFreeCode(BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final codeProvider = Provider.of<CodeProvider>(context, listen: false);
      codeProvider.changeCode("");
      codeProvider.changeTimestamp(DateTime.now());
      if (authProvider.userModel.phoneNumber != "") {
        final documentReference2 = await FirebaseFirestore.instance
            .collection(FirestorePath.getCodes())
            .where('user_id', isEqualTo: authProvider.userModel.phoneNumber)
            .where('close', isEqualTo: false)
            .where('free_3', isEqualTo: true)
            .get();
        if (documentReference2.size != 0) {
          documentReference2.docs.map((e) async {
            if (e["endDateTime"].toDate().isAfter(DateTime.now())) {
              // codeProvider.changeCode(e["code"]);
              // codeProvider.changeTimestamp(e["endDateTime"].toDate());
            } else {
              FirebaseFirestore.instance
                  .collection('codes')
                  .doc(e.id)
                  .delete()
                  .then((value) {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(authProvider.userModel.phoneNumber)
                    .update({
                  'free_code': FieldValue.increment(1),
                });
              });
            }
          }).toList();
        }
      }
    } catch (e) {}
  }

  static Future<void> getCodeDis(context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      FirebaseFirestore.instance
          .collection('users')
          .doc(authProvider.userModel.phoneNumber)
          .get()
          .then((value) async {
        String endDate = DateTime.now().add(Duration(hours: 72)).toString();
        addCode(context, value['codeEasy'], 'Easy', endDate);
        prefs.setString('codeEasy', '1');
      });
    } catch (e) {}
  }

  static Future<void> getAllSizeUser(context) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((value) async {
        int size = value.docs.length;
        Provider.of<AccountProvider>(context, listen: false).userL(size);
      });
    } catch (e) {}
  }

  static Future<void> getOfferCount(context, String id) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      int number = 0;
      int num;
      final _firebase = FirebaseFirestore.instance;
      await _firebase
          .collection('users')
          .doc(authProvider.userModel.phoneNumber)
          .get()
          .then((user) async {
        _firebase
            .collection('codes')
            .where('user_id', isEqualTo: authProvider.userModel.phoneNumber)
            .where('offerId', isEqualTo: id)
            .where(
              'free',
              isEqualTo: false,
            )
            .where(
              'free_3',
              isEqualTo: false,
            )
            .get()
            .then((code) => {
                  if (code.size != null)
                    {
                      if (user['subscription1'] == true)
                        {
                          number = 1 - code.docs.length,
                          num = number == -1 ? 0 : number,
                          Provider.of<AccountProvider>(context, listen: false)
                              .offerCount(num),
                        }
                      else if (user['subscription12m'] == true)
                        {
                          number = 6 - code.docs.length,
                          num = number == -1 ? 0 : number,
                          Provider.of<AccountProvider>(context, listen: false)
                              .offerCount(num),
                        }
                      else if (user['subscription6m'] == true)
                        {
                          number = 3 - code.docs.length,
                          num = number == -1 ? 0 : number,
                          Provider.of<AccountProvider>(context, listen: false)
                              .offerCount(num),
                        }
                    }
                });
      });
    } catch (e) {}
  }

  static Future<void> userNumberGetAuth(context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final _firebase = FirebaseFirestore.instance;
      await _firebase
          .collection('users')
          .doc(authProvider.userModel.phoneNumber)
          .get()
          .then((user) async {
        if (user['fff'] == true) {
          String _number = user['family_phone'];
          var _prot = user['profit'];

          Provider.of<AccountProvider>(context, listen: false)
              .phoneNum(_number);
          Provider.of<AccountProvider>(context, listen: false)
              .protfo(_prot.toInt());
        } else {
          Provider.of<AccountProvider>(context, listen: false)
              .phoneNum(authProvider.userModel.phoneNumber);
        }
        if (user['family'] == true) {
          Provider.of<AccountProvider>(context, listen: false).fmlle(true);
        }
      });
    } catch (e) {}
  }

  static Future<void> timeUpd(context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String number =
          Provider.of<AccountProvider>(context, listen: false).phoneNumber == ""
              ? authProvider.userModel.phoneNumber
              : Provider.of<AccountProvider>(context, listen: false)
                  .phoneNumber;
      final _firebase = FirebaseFirestore.instance;
      await _firebase
          .collection('sharing_users')
          .doc(number)
          .get()
          .then((use) async {
        if (use["endDateTime"]
            .toDate()
            .isAfter(DateTime.now().add(Duration(days: 7)))) {
        } else {
          Provider.of<AccountProvider>(context, listen: false).timeIsAfre(true);
        }
      });
    } catch (e) {}
  }

  static Future<void> delatSub(context) async {
    String number =
        Provider.of<AccountProvider>(context, listen: false).phoneNumber;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final _firebase = FirebaseFirestore.instance;
    await _firebase
        .collection('sharing_users')
        .doc(number)
        .get()
        .then((dela) async {
      if (dela.exists) {
        if (dela["endDateTime"].toDate().isAfter(DateTime.now())) {
        } else {
          _firebase
              .collection('users')
              .doc(authProvider.userModel.phoneNumber)
              .update({
            'free_code': 0,
            'notf': '',
            'subscription1': false,
            'subscription12m': false,
            'subscription6m': false,
          });
          await _firebase
              .collection('users')
              .doc(authProvider.userModel.phoneNumber)
              .get()
              .then((valueDelte) {
            if (valueDelte['family'] == true) {
              _firebase
                  .collection('users')
                  .doc(valueDelte['family_phone'])
                  .update({
                'subscription12m': false,
                'fff': false,
                'family_phone': '',
              });
            }
          });
        }
      }
    });
  }

  static void shearUrlMeth(context) async{
 await   FirebaseFirestore.instance.collection('shear').doc('IGei4gJTn89xyNBE2vTU').get().then((url) {
      String google = url['google'];
      String apple = url['apple'];
      List urlShear = url['list'];
      print(urlShear);
      Provider.of<AccountProvider>(context,listen: false).shearUrl(google, apple, urlShear);
    });
  }

  static Future<void> delaetFamly(context) async {
    print('connectedTest1');
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(authProvider.userModel.phoneNumber)
        .get()
        .then((valueDelte) {
      print('valueDelte${valueDelte['profit']}');
      var x = valueDelte['profit'];
      Provider.of<AccountProvider>(context, listen: false).getBiln(x.toInt());
      if (valueDelte['family'] &&
          valueDelte['family_phone'].isNotEmpty &&
          valueDelte['fff'] == false &&
          valueDelte['subscription12m'] == false) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(valueDelte['family_phone'])
            .update({
          'family_phone': '',
          'family': false,
          'subscription12m': false,
          'profit': valueDelte['profit'],
        }).then((value) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(authProvider.userModel.phoneNumber)
              .update({
            'family': false,
            'family_phone': '',
          });
        });
      } else {}
    });
  }
}
