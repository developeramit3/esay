import 'dart:async';
import 'dart:io';
 import 'package:esay/widgetEdit/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay/caches/sharedpref/shared_preference_helper.dart';
import 'package:esay/functions/save_code.dart';
import 'package:esay/models/offer_model.dart';
import 'package:esay/models/store_model.dart';
import 'package:esay/providers/account_provider.dart';
import 'package:esay/providers/auth_provider.dart';
import 'package:esay/providers/bottom_animation_provider.dart';
import 'package:esay/providers/code_provider.dart';
import 'package:esay/providers/loading_provider.dart';
import 'package:esay/providers/rating_provider.dart';
import 'package:esay/providers/store_provider.dart';
import 'package:esay/ui/offers/offer_details_screen.dart';
import 'package:esay/ui/store/store_home.dart';
import 'package:esay/widgets/code_offer.dart';
import 'package:esay/widgets/show_toast.dart';
import 'package:esay/widgets/sucess_sharing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import '../models/user_model.dart';
import 'firestore_path.dart';
import 'firestore_service.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _firestoreService = FirestoreService.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;
  // final _firebaseStorage = FirebaseStorage.instance.ref();

  /*===================================Users=========================================*/

  Future<void> setUsers(UserModel userModel) async =>
      await _firestoreService.setData(
        path: FirestorePath.users(userModel.phoneNumber),
        data: userModel.toMap(),
      );
/*===================================Offers=========================================*/

  Future<void> updateFavoriteBtn(bool liked, String offerId) async {
    final _batchUpdate = FirebaseFirestore.instance.batch();
    final documentReference =
        _firebaseFirestore.collection(FirestorePath.offers()).doc(offerId);
    _batchUpdate.update(documentReference, {
      'likes': FieldValue.increment(
        (liked ? (-1) : (1)),
      ),
    });
    await _batchUpdate.commit();
  }
  /*===================================Stores=========================================*/

  Future<void> enterStore(BuildContext context, String password) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    final storePovider = Provider.of<StorePovider>(context, listen: false);
    loadingProvider.changeLoading(true);
    final documentReference = await _firebaseFirestore
        .collection(FirestorePath.stores())
        .doc(password)
        .get();
    if (documentReference.exists) {
      loadingProvider.changeLoading(false);
      StoreModel _storeModel =
          StoreModel.fromMap(documentReference.data(), documentReference.id);
      storePovider.changeEasyCost(double.parse(_storeModel.easyCost));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => StoreHome(storeModel: _storeModel)));
    } else {
      loadingProvider.changeLoading(false);
      showToast("This account is not exist", Colors.red, context);
    }
  }

  Future<void> loginStore(BuildContext context, StoreModel storeModel) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    final storePovider = Provider.of<StorePovider>(context, listen: false);
    loadingProvider.changeLoading(true);
    final documentReference = await _firebaseFirestore
        .collection(FirestorePath.stores())
        .doc(storeModel.password)
        .get();
    if (documentReference.exists) {
      loadingProvider.changeLoading(false);
      StoreModel _storeModel =
          StoreModel.fromMap(documentReference.data(), documentReference.id);
      if (storeModel.name == _storeModel.name) {
        storePovider.changeEasyCost(double.parse(_storeModel.easyCost));
        SharedPreferenceHelper().setStorePrefs(storeModel.password);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => StoreHome(storeModel: storeModel)));
      } else {
        showToast("This account is not exist", Colors.red, context);
      }
    } else {
      loadingProvider.changeLoading(false);
      showToast("This account is not exist", Colors.red, context);
    }
  }

  Future<void> getDetailsOfferSecret(BuildContext context) async {
    OfferModel offerModel;
    OfferStoreModel offerStoreModel;
    StoreModel storeModel;
    final documentReference1 =
        await _firebaseFirestore.collection(FirestorePath.offersSecret()).get();
    if (documentReference1.docs[0].exists) {
      print('tree');
      offerModel = OfferModel.fromMap(
          documentReference1.docs[0].data(), documentReference1.docs[0].id);
      final documentReference2 = await _firebaseFirestore
          .collection(FirestorePath.storeDetailsSecret(offerModel.id))
          .doc(offerModel.store)
          .get();
      offerStoreModel = OfferStoreModel.fromMap(
          documentReference2.data(), documentReference2.id);
      if (offerStoreModel.id != null) {
        final documentReference3 = await _firebaseFirestore
            .collection(FirestorePath.stores())
            .doc(offerModel.store)
            .get();
        storeModel = StoreModel.fromMap(
            documentReference3.data(), documentReference3.id,
            offerStoreModelData: offerStoreModel);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OfferDetailsScreen(
                  offerModel: offerModel, storeModel: storeModel),
            ));
      }
    }
  }

  Future<void> getDetailsStoreAndOffer(
      BuildContext context, OfferModel offerModel) async {
    final documentReference1 = await _firebaseFirestore
        .collection(FirestorePath.stores())
        .doc(offerModel.store)
        .get();
    if (documentReference1.exists) {
      final documentReference2 = await _firebaseFirestore
          .collection(FirestorePath.storeDetails(offerModel.id))
          .doc(offerModel.store)
          .get();
      if (documentReference2.exists) {
        print(documentReference2.id);
        OfferStoreModel offerStoreModel = OfferStoreModel.fromMap(
            documentReference2.data(), documentReference2.id);
        StoreModel storeModel = StoreModel.fromMap(
            documentReference1.data(), documentReference1.id,
            offerStoreModelData: offerStoreModel);
       // SetNot.getCodeDetail(context, offerModel);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OfferDetailsScreen(
                  offerModel: offerModel, storeModel: storeModel),
            ));
      }
    }
  }

  /*===================================Codes=========================================*/

  Future<void> getCodes(BuildContext context) async {
    final codeProvider = Provider.of<CodeProvider>(context, listen: false);
    final documentReference = await _firebaseFirestore
        .collection(FirestorePath.getCodes())
        .where('close', isEqualTo: true)
        .get();
    if (documentReference.size != 0) {
      codeProvider.removeCodes();
      documentReference.docs.map((e) {
        codeProvider.changeCodes(e.data()['code']);
        SharedPreferenceHelper().removeCodesPrefs(e.data()['code']);
      }).toList();
    }
  }

  Future<void> checkCode(
      BuildContext context, String storeModel, String code) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    final codeProvider = Provider.of<CodeProvider>(context, listen: false);
    loadingProvider.changeLoading(true);
    print("$storeModel.i$storeModel");
    final documentReference = await _firebaseFirestore
        .collection("codes")
        .where('storeId', isEqualTo: storeModel)
        .where('code', isEqualTo: code)
        .where('close', isEqualTo: false)
        .get();
    loadingProvider.changeLoading(false);
    if (documentReference.size != 0) {
      print("11111");
      documentReference.docs.map((e) {
        if (e["endDateTime"].toDate().isAfter(DateTime.now())) {
          codeProvider.changeCodeId(e.id);
          showToast("code6", Colors.green, context, center: true);
        } else {
          showToast("code7", Colors.red, context, center: true);
        }
      }).toList();
    } else {
      showToast("code7", Colors.red, context, center: true);
    }
  }

  Future<void> checkRate(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final ratingProvider = Provider.of<RatingProvider>(context, listen: false);

    if (authProvider.userModel.phoneNumber != "") {
      final documentReference = await _firebaseFirestore
          .collection(FirestorePath.getCodes())
          .where('userId', isEqualTo: authProvider.userModel.phoneNumber)
          .where('close', isEqualTo: true)
          .get();
      if (documentReference.size == 1) {
        SharedPreferenceHelper().getRate().then((value) {
          if (value == false) {
            ratingProvider.changeShow(true);
          }
        });
      }
    }
  }

  Future<void> getCodeDetails(
      BuildContext context, OfferModel offerModel) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final codeProvider = Provider.of<CodeProvider>(context, listen: false);
    codeProvider.changeCode("");
    codeProvider.changeTimestamp(DateTime.now());
    if (authProvider.userModel.phoneNumber != "") {
      final documentReference2 = await _firebaseFirestore
          .collection(FirestorePath.getCodes())
          .where('userId', isEqualTo: authProvider.userModel.phoneNumber)
          .where('offerId', isEqualTo: offerModel.id)
          .where('close', isEqualTo: false)
          .get();
      if (documentReference2.size != 0) {
        print("documentReference2.size${documentReference2.size}");
        documentReference2.docs.map((e) {
          if (e["endDateTime"].toDate().isAfter(DateTime.now())) {
            codeProvider.changeCode(e["code"]);
            codeProvider.changeTimestamp(e["endDateTime"].toDate());
          }
        }).toList();
      }
    }
  }

  Future<void> getCode(BuildContext context, OfferModel offerModel,
      StoreModel storeModel) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final cIndexProvider = Provider.of<CIndexProvider>(context, listen: false);
    if (authProvider.userModel.phoneNumber == "") {
      Navigator.of(context).pop();
      cIndexProvider.changeCIndex(3);
      cIndexProvider.changeNameNav("account");
      final newRouteName = "/accountScreen";
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
    } else {
      showProgressDialog(
          context: context,
          loadingText: "",
          backgroundColor: HexColor('#2c6bec'));
      try {
        final response = await InternetAddress.lookup('www.kindacode.com');
        if (response.isNotEmpty) {
          final documentReference1 = await _firebaseFirestore
              .collection(FirestorePath.getCodes())
              .get();
          final documentReference2 = await _firebaseFirestore
              .collection(FirestorePath.getCodes())
              .where('userId', isEqualTo: authProvider.userModel.phoneNumber)
              .where('offerId', isEqualTo: offerModel.id)
              .where('close', isEqualTo: false)
              .get();
          if (documentReference2.size == 0) {
            await setCode(context, documentReference1, offerModel, storeModel);
            await updateNumCodes(offerModel.id);
          } else {
            documentReference2.docs.map((e) async {
              if (e["endDateTime"].toDate().isBefore(DateTime.now())) {
                await setCode(
                    context, documentReference1, offerModel, storeModel);
                await updateNumCodes(offerModel.id);
              } else {
                showToast("code4", Colors.red, context);
              }
            }).toList();
          }
        }
      } on SocketException catch (err) {
        print(err);
        showToast("internet", Colors.red, context);
      }
    }
  }

  Future<void> setCode(BuildContext context, QuerySnapshot documentReference1,
      OfferModel offerModel, StoreModel storeModel) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final codeProvider = Provider.of<CodeProvider>(context, listen: false);
    String generateCode = randomBetween(100000, 900000).toString();
    final documentReference = await _firebaseFirestore
        .collection(FirestorePath.getCodes())
        .where('storeId', isEqualTo: storeModel.id)
        .where('code', isEqualTo: generateCode)
        .where('close', isEqualTo: false)
        .get();
    if (documentReference.size == 0) {
      await _firestoreService.setData(
        path: FirestorePath.setCodes(DateTime.now().toIso8601String()),
        data: {
          "userId": authProvider.userModel.phoneNumber,
          "offerId": offerModel.id,
          "code": generateCode,
          "storeId": offerModel.store,
          "dateTime": DateTime.now(),
          "endDateTime":
              DateTime.now().add(Duration(hours: offerModel.timeCode)),
          "cost": "0.0",
          "close": false,
          "tokenId": authProvider.userModel.tokenId
        },
      );
      String endDate =
          DateTime.now().add(Duration(hours: offerModel.timeCode)).toString();
      addCode(context, generateCode, storeModel.name, endDate);
      codeProvider.changeCode(generateCode);
      codeProvider.changeTimestamp(
          DateTime.now().add(Duration(hours: offerModel.timeCode)));
      showCodeDialog(context, generateCode, offerModel.timeCode);
    } else {
      String code = DateTime.now().year.toString() +
          DateTime.now().month.toString() +
          DateTime.now().hour.toString() +
          DateTime.now().second.toString();
      _firestoreService.setData(
        path: FirestorePath.setCodes(DateTime.now().toIso8601String()),
        data: {
          "userId": authProvider.userModel.phoneNumber,
          "offerId": offerModel.id,
          "code": code,
          "storeId": offerModel.store,
          "dateTime": DateTime.now(),
          "endDateTime":
              DateTime.now().add(Duration(hours: offerModel.timeCode)),
          "cost": "0.0",
          "close": false,
          "tokenId": authProvider.userModel.tokenId
        },
      );
      String endDate =
          DateTime.now().add(Duration(hours: offerModel.timeCode)).toString();
      addCode(context, generateCode, storeModel.name, endDate);
      codeProvider.changeCode(code);
      codeProvider.changeTimestamp(
          DateTime.now().add(Duration(hours: offerModel.timeCode)));
      showCodeDialog(context, code, offerModel.timeCode);
    }
  }

  Future<void> updateNumCodes(String offerId) async {
    final _batchUpdate = FirebaseFirestore.instance.batch();
    final documentReference =
        _firebaseFirestore.collection(FirestorePath.offers()).doc(offerId);
    _batchUpdate.update(documentReference, {
      'numCodesTaken': FieldValue.increment(1),
    });
    await _batchUpdate.commit();
  }

  Future<void> calcOffer(
      BuildContext context,
      String storeId,
      String code,
      String cost,
      String total,
      String totalNow,
      String customer,
      String customerNow) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    final codeProvider = Provider.of<CodeProvider>(context, listen: false);
    loadingProvider.changeLoading1(true);
    final documentReference = await _firebaseFirestore
        .collection(FirestorePath.getCodes())
        .where('code', isEqualTo: code)
        .get();
    if (documentReference.size != 0) {
      await updateCost(documentReference.docs[0].id, cost);
      // final documentReference1 = await _firebaseFirestore
      //     .collection(FirestorePath.getCodes())
      //     .where('userId', isEqualTo: documentReference.docs[0]['userId'])
      //     .where('storeId', isEqualTo: storeId)
      //     .where('close', isEqualTo: true)
      //     .get();
      // if (documentReference1.size == 0) {
      await updateStoreData(storeId, total, totalNow, customer, customerNow);
      // }
      // else {
      //   await updateStoreData1(storeId, total, totalNow);
      // }
      await closeCode(codeProvider.getCodeId);
      loadingProvider.changeLoading1(false);
      codeProvider.changeCodeId("");
      showToast("code8", Colors.green, context, center: true);
    }
  }

  Future<void> updateCost(String codeId, String cost) async {
    final _batchUpdate = FirebaseFirestore.instance.batch();
    var long2 = double.parse(cost);
    final documentReference =
        _firebaseFirestore.collection(FirestorePath.getCodes()).doc(codeId);
    _batchUpdate.update(documentReference, {'cost': cost});
    await _batchUpdate.commit().then((_) {
      documentReference.get().then((us) {
        final checkus =
            FirebaseFirestore.instance.collection('users').doc(us['user_id']);
        checkus.get().then((value) {
          double cos = value['profit'] + long2;
          checkus.update({
            'profit': cos,
          });
        });
      });
    });
  }

  Future<void> closeCode(String codeId) async {
    final _batchUpdate = FirebaseFirestore.instance.batch();
    final documentReference =
        _firebaseFirestore.collection(FirestorePath.getCodes()).doc(codeId);
    _batchUpdate.update(documentReference, {'close': true});
    await _batchUpdate.commit().then((_) {
      FirebaseFirestore.instance.collection('users').doc().get();
    });
  }

  Future<void> updateStoreData(String storeId, String total, String totalNow,
      String customer, String customerNow) async {
    final _batchUpdate = FirebaseFirestore.instance.batch();
    final documentReference =
        _firebaseFirestore.collection(FirestorePath.stores()).doc(storeId);
    _batchUpdate.update(documentReference, {
      'total': total,
      'totalNow': totalNow,
      'customers': customer,
      'customersNow': customerNow
    });
    await _batchUpdate.commit();
  }

  Future<void> updateStoreData1(
      String storeId, String total, String totalNow) async {
    final _batchUpdate = FirebaseFirestore.instance.batch();
    final documentReference =
        _firebaseFirestore.collection(FirestorePath.stores()).doc(storeId);
    _batchUpdate.update(documentReference, {
      'total': total,
      'totalNow': totalNow,
    });
    await _batchUpdate.commit();
  }

  Future<void> calcDiscountEasy(BuildContext context, String total,
      String discount, String easyCost) async {
    double cost = ((double.parse(total) * double.parse(discount) / 100)) +
        double.parse(easyCost);
    String totalCost = cost.toStringAsFixed(1);
    showToast(totalCost + " شيكل", Colors.green, context);
  }

  Future<void> calcCostUser(BuildContext context) async {
    final codeProvider = Provider.of<CodeProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    codeProvider.changeCost(0.0);

    if (authProvider.userModel.phoneNumber != "") {
      final documentReference = await _firebaseFirestore
          .collection(FirestorePath.getCodes())
          .where('userId', isEqualTo: authProvider.userModel.phoneNumber)
          .get();
      if (documentReference.size != 0) {
        documentReference.docs.map((e) {
          double cost = codeProvider.getCost + double.parse(e['cost']);
          codeProvider.changeCost(cost);
        }).toList();
      }
    }
  }

/*======================================store===================================*/
  Future<void> getStores(BuildContext context) async {
    final storePovider = Provider.of<StorePovider>(context, listen: false);

    final documentReference =
        await _firebaseFirestore.collection(FirestorePath.stores()).doc().get();
    if (documentReference.exists) {
      storePovider.changeLenght(documentReference.data().length);
      StoreModel _storeModel =
          StoreModel.fromMap(documentReference.data(), documentReference.id);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => StoreHome(storeModel: _storeModel)));
    }
  }

/*===================================Sharing=====================================*/
  Future<void> checkUser(
      BuildContext context,
      String codeDs,
      code,
      String phone,
      String storeId,
      int days,
      double calc,
      String easyCost,
      String storeName,
      var scaffoldKey) async {
    print("111$days");
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    loadingProvider.changeLoading(true);
    final querySnapshot = await FirebaseFirestore.instance
        .collection(FirestorePath.checkUser())
        .doc(phone)
        .get();
    final snapshot = await FirebaseFirestore.instance
        .collection(FirestorePath.checkUser())
        .doc(phone)
        .get();
    if (codeDs.isNotEmpty) {
      if (snapshot['codeEasy'] == codeDs) {
        await setUserSharing(
            context, code, phone, storeId, days, calc, storeName, scaffoldKey);
        loadingProvider.changeLoading(false);
      } else {
        shoCodeD(context);
      }
    } else {
      if (querySnapshot.exists) {
        print("ok");
        await setUserSharing(
            context, code, phone, storeId, days, calc, storeName, scaffoldKey);
        // } else {
        //   DateTime endDateTime = querySnapshot.docs[0]
        //       .data()['endDateTime']
        //       .toDate()
        //       .add(Duration(days: days));
        //   await udateUserSharing(context, querySnapshot.docs[0].id, endDateTime);
        // }+970598427047
        // await updateEasyCostStore(storeId, easyCost);
        loadingProvider.changeLoading(false);
      } else {
        loadingProvider.changeLoading(false);
        showToast(
            "This user is not exist", Colors.red, scaffoldKey.currentContext,
            center: true);
      }
    }
  }

  Future<void> udateUserSharing(
      BuildContext context, String shareId, DateTime endDateTime) async {
    final _batchUpdate = FirebaseFirestore.instance.batch();
    final documentReference = _firebaseFirestore
        .collection(FirestorePath.checkSharingUsers())
        .doc(shareId);
    _batchUpdate.update(documentReference, {
      "endDateTime": endDateTime,
    });
    await _batchUpdate.commit();
  }

  Future<void> setUserSharing(
      BuildContext context,
      String code,
      String phone,
      String storeId,
      int days,
      double calc,
      String storeName,
      var scaffoldKey) async {
    final querySnapshotSub =
        await FirebaseFirestore.instance.collection('subscription').doc().get();
    await FirebaseFirestore.instance
        .collection(FirestorePath.checkUser())
        .doc(phone)
        .get()
        .then((value) {
      if (value.exists) {
        try {
          FirebaseFirestore.instance
              .collection(FirestorePath.checkUser())
              .doc(phone)
              .get()
              .then((value) async {
            print(" days $days");
            if (days == 360) {
              final qouer = await Firestore.instance
                  .collection('sharing_users')
                  .where('phoneNumber', isEqualTo: phone)
                  .get();
              if (qouer.size == 0) {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(phone)
                    .update({
                  'codeEasy': "",
                  'notifications_check': true,
                  'notf': "",
                  "subscription12m": true,
                  "subscription6m": false,
                  "subscription1": false,
                }).then((_) async {
                  checkSharing(
                    phone: phone,
                    close: false,
                    easyCost: calc,
                    endDate: DateTime.now().add(Duration(days: days)),
                    nameStore: storeName,
                    storeId: storeId,
                    time: DateTime.now(),
                  );
                });
                sucessSharing(context, calc.toStringAsFixed(1), scaffoldKey);
              } else {
                print("else");
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(phone)
                    .get()
                    .then((valueUser1) {
                  print('else2');
                  // int add = valueUser1['subscription_12m'];
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(phone)
                      .update({
                    'codeEasy': "",
                    'notifications_check': true,
                    'notf': "",
                    "subscription12m": true,
                  }).then((value) async {
                    FirebaseFirestore.instance
                        .collection("codes")
                        .where("user_id", isEqualTo: phone)
                        .get()
                        .then((value) {
                      value.docs.forEach((element) {
                        FirebaseFirestore.instance
                            .collection("codes")
                            .doc(element.id)
                            .delete()
                            .then((value) {
                          print("Success!");
                        });
                      });
                    });
                    print('part 2');
                    await FirebaseFirestore.instance
                        .collection('sharing_users')
                        .doc(phone)
                        .get()
                        .then((valueSharing) async {
                      print("easyCosts${valueSharing['easyCost']}");
                      print(
                          "subscription ${valueSharing['Subscription_counter']}");
                      double easyCost1 = valueSharing['easyCost'] + calc;
                      int subscription =
                          valueSharing['Subscription_counter'] + 1;
                      // print("easyCosts${valueSharing['easyCost']}");
                      //print("subscription ${valueSharing['Subscription_counter']}");
                      await FirebaseFirestore.instance
                          .collection('sharing_users')
                          .doc(phone)
                          .update({
                        'dateTime': DateTime.now(),
                        'endDateTime': DateTime.now().add(Duration(days: days)),
                        'Subscription_counter': subscription,
                        'easyCost': easyCost1,
                        'storeId': storeId,
                        'storeName': storeName, // 598427047
                      });
                    });
                  });
                });
                sucessSharing(context, calc.toStringAsFixed(1), scaffoldKey);
              }
            } else if (days == 180) {
              final qouer = await Firestore.instance
                  .collection('sharing_users')
                  .where('phoneNumber', isEqualTo: phone)
                  .get();
              if (qouer.size == 0) {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(phone)
                    .update({
                  'codeEasy': "",
                  'notifications_check': true,
                  'notf': "",
                  "subscription12m": false,
                  "subscription6m": true,
                  "subscription1": false,
                }).then((_) async {
                  FirebaseFirestore.instance
                      .collection("codes")
                      .where("user_id", isEqualTo: phone)
                      .get()
                      .then((value) {
                    value.docs.forEach((element) {
                      FirebaseFirestore.instance
                          .collection("codes")
                          .doc(element.id)
                          .delete()
                          .then((value) {
                        print("Success!");
                      });
                    });
                  });
                  checkSharing(
                    phone: phone,
                    close: false,
                    easyCost: calc,
                    endDate: DateTime.now().add(Duration(days: days)),
                    nameStore: storeName,
                    storeId: storeId,
                    time: DateTime.now(),
                  );
                });
                sucessSharing(context, calc.toStringAsFixed(1), scaffoldKey);
              } else {
                print("else");
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(phone)
                    .get()
                    .then((valueUser1) {
                  print('else2');
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(phone)
                      .update({
                    'codeEasy': "",
                    'notifications_check': true,
                    'notf': "",
                    "subscription6m": true,
                  }).then((value) async {
                    FirebaseFirestore.instance
                        .collection("codes")
                        .where("user_id", isEqualTo: phone)
                        .get()
                        .then((value) {
                      value.docs.forEach((element) {
                        FirebaseFirestore.instance
                            .collection("codes")
                            .doc(element.id)
                            .delete()
                            .then((value) {
                          print("Success!");
                        });
                      });
                    });
                    print('part 2');
                    await FirebaseFirestore.instance
                        .collection('sharing_users')
                        .doc(phone)
                        .get()
                        .then((valueSharing) async {
                      print("easyCosts${valueSharing['easyCost']}");
                      print(
                          "subscription ${valueSharing['Subscription_counter']}");
                      double easyCost1 = valueSharing['easyCost'] + calc;
                      int subscription =
                          valueSharing['Subscription_counter'] + 1;
                      // print("easyCosts${valueSharing['easyCost']}");
                      //print("subscription ${valueSharing['Subscription_counter']}");
                      await FirebaseFirestore.instance
                          .collection('sharing_users')
                          .doc(phone)
                          .update({
                        'dateTime': DateTime.now(),
                        'endDateTime': DateTime.now().add(Duration(days: days)),
                        'Subscription_counter': subscription,
                        'easyCost': easyCost1,
                        'storeId': storeId,
                        'storeName': storeName, // 598427047
                      });
                    });
                  });
                });
                sucessSharing(context, calc.toStringAsFixed(1), scaffoldKey);
              }
            } else if (days == 30) {
              final qouer = await Firestore.instance
                  .collection('sharing_users')
                  .where('phoneNumber', isEqualTo: phone)
                  .get();
              if (qouer.size == 0) {
                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(phone)
                    .update({
                  "subscription12m": false,
                  "subscription6m": false,
                  "subscription1": true,
                }).then((_) async {
                  FirebaseFirestore.instance
                      .collection("codes")
                      .where("user_id", isEqualTo: phone)
                      .get()
                      .then((value) {
                    value.docs.forEach((element) {
                      FirebaseFirestore.instance
                          .collection("codes")
                          .doc(element.id)
                          .delete()
                          .then((value) {
                        print("Success!");
                      });
                    });
                  });
                  checkSharing(
                    phone: phone,
                    close: false,
                    easyCost: calc,
                    endDate: DateTime.now().add(Duration(days: days)),
                    nameStore: storeName,
                    storeId: storeId,
                    time: DateTime.now(),
                  );
                });
                sucessSharing(context, calc.toStringAsFixed(1), scaffoldKey);
              } else {
                print("else");
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(phone)
                    .get()
                    .then((valueUser1) {
                  print('else2');
                  int add = value['subscription_1'] + 1;
                  print(add);
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(phone)
                      .update({
                    "subscription1": true,
                  }).then((value) async {
                    print('part 2');
                    FirebaseFirestore.instance
                        .collection("codes")
                        .where("user_id", isEqualTo: phone)
                        .get()
                        .then((value) {
                      value.docs.forEach((element) {
                        FirebaseFirestore.instance
                            .collection("codes")
                            .doc(element.id)
                            .delete()
                            .then((value) {
                          print("Success!");
                        });
                      });
                    });
                    await FirebaseFirestore.instance
                        .collection('sharing_users')
                        .doc(phone)
                        .get()
                        .then((valueSharing) async {
                      int easyCosts = valueSharing['easyCost'] + calc.toInt();
                      int subscription =
                          valueSharing['Subscription_counter'] + 1;
                      await FirebaseFirestore.instance
                          .collection('sharing_users')
                          .doc(phone)
                          .update({
                        'dateTime': DateTime.now(),
                        'endDateTime': DateTime.now().add(Duration(days: days)),
                        'Subscription_counter': subscription,
                        'easyCost': easyCosts,
                        'storeId': storeId,
                        'storeName': storeName,
                      });
                    });
                  });
                });
              }
              sucessSharing(context, calc.toStringAsFixed(1), scaffoldKey);
            }
          });
        } catch (e) {
          showToast(e.toString(), Colors.red, scaffoldKey.currentContext,
              center: true);
        }
      } else {
        // show error is user is not have acc
        print("you have error"); //598427047

        showToast("This user is already have account", Colors.red,
            scaffoldKey.currentContext,
            center: true);
      }
    });
  }

  Future<void> updateEasyCostStore(String storeId, String easyCost) async {
    final _batchUpdate = FirebaseFirestore.instance.batch();
    final documentReference =
        _firebaseFirestore.collection(FirestorePath.stores()).doc(storeId);
    _batchUpdate.update(documentReference, {
      "easyCost": easyCost,
    });
    await _batchUpdate.commit();
  }

  /*=============================Account==========================================*/
  Future<void> checkUserSharing(BuildContext context) async {
    final accountProvider =
        Provider.of<AccountProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final documentReference = await _firebaseFirestore
        .collection(FirestorePath.checkSharingUsers())
        .where('phoneNumber', isEqualTo: authProvider.userModel.phoneNumber)
        .where('close', isEqualTo: false)
        .get();
    if (documentReference.size != 0) {
      accountProvider.changeShowShare(true);
    }
  }

  Future<void> checkSharing(
      {bool close,
      DateTime time,
      double easyCost,
      DateTime endDate,
      String phone,
      String storeId,
      String nameStore}) async {
    await FirebaseFirestore.instance
        .collection(FirestorePath.checkSharingUsers())
        .doc(phone)
        .set({
      'close': close,
      'dateTime': time,
      'easyCost': easyCost.toInt(),
      'endDateTime': endDate,
      'phoneNumber': phone,
      'storeName': nameStore,
    });
  }
}
