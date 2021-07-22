import 'package:cloud_firestore/cloud_firestore.dart';
class AppGatDataEdit {

  static  Future check1Saerch(itemId) async {
    FirebaseFirestore.instance
        .collection(itemId).get();
  }
}