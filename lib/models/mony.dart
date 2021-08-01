import 'package:cloud_firestore/cloud_firestore.dart';

class MonueModel {
  final String id;

  MonueModel({
    this.id,
  });

  factory MonueModel.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    String id = documentId;


    return MonueModel(
        id: id);
  }
}
