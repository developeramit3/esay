import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay/functions/save_code.dart';
import 'package:esay/models/offer_model.dart';
import 'package:esay/models/store_model.dart';
import 'package:esay/providers/auth_provider.dart';
import 'package:esay/providers/code_provider.dart';
import 'package:esay/widgets/code_offer.dart';
import 'package:esay/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custdelog.dart';

class GetCodeEdit {

  static void  check_sub(context , OfferModel offerModel,StoreModel storeModel) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final codeProvider = Provider.of<CodeProvider>(context, listen: false);
    FirebaseFirestore.instance.collection("codes")
        .where("store_id",isEqualTo:offerModel.id)
        .where("user_id",isEqualTo:authProvider.userModel.phoneNumber)
        .get().then((num) {

          FirebaseFirestore.instance.collection("users")
              .doc(authProvider.userModel.phoneNumber).get().then((subs) {
          int count = num.docs.length.toInt();
          print(count);
            if(subs["subscription1"] == true ){
             print(subs["subscription_1"]);
              if(subs["subscription_1"] <= count ){
                print("this Offer is not have code for this store");
                 }else{
                getCodeEasy(context ,offerModel,storeModel);
              }
            }
          if(subs["subscription12"] == true  ){
            print(subs["subscription_12m"]);
            if(subs["subscription_12m"] <= count ){
              print("this Offer is not have code for this store");
            }else{
              getCodeEasy(context ,offerModel,storeModel);
            }
          }else  if(subs["subscription6"] == true ){
            print(subs["subscription_6m"]);
            if(subs["subscription_6m"] <= count ){
            }else{
              getCodeEasy(context ,offerModel,storeModel);
            }
          }else {
            print("not have sub");
          }

          });
    });
  }
  static void getCodeEasy(context , OfferModel offerModel,StoreModel storeModel) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final codeProvider = Provider.of<CodeProvider>(context, listen: false);
    try {
      String id = Random().nextInt(1000000).toString();
          print(id);
          FirebaseFirestore.instance
              .collection("codes")
              .doc()
              .set({
            "code": id,
            "user_id":authProvider.userModel.phoneNumber,
            "open": false,
            "offerId": offerModel.id,
            "storeId": offerModel.store,
            "dateTime": DateTime.now(),
            "endDateTime": DateTime.now().add(Duration(hours: offerModel.timeCode)),
            "cost": "0.0",
            "close": false,
            "tokenId": authProvider.userModel.tokenId
          }).then((_) {
            String endDate =
            DateTime.now().add(Duration(hours: offerModel.timeCode)).toString();
            addCode(context, id, storeModel.name, endDate);
            codeProvider.changeCode(id);
            showCodeDialog(context, id, offerModel.timeCode);
            codeProvider.changeTimestamp(
                DateTime.now().add(Duration(hours: offerModel.timeCode)));
          }).catchError((e) {
            print(e);
          });
    } catch (e) {
      print(e.print);
    }
  }
}
