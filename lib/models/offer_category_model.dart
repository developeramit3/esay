import 'package:cloud_firestore/cloud_firestore.dart';

class OffersCategoryModel {
  final String id;
  final String name;
  final String logo;
  final String photo;
  final Timestamp date;

  OffersCategoryModel({
    this.id,
    this.name,
    this.logo,
    this.photo,
    this.date,
  });

  factory OffersCategoryModel.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    String id = documentId;
    String name = data['name'];
    String logo = data['logo'];
    String photo = data['photo'];
    Timestamp date = data['date'];

    return OffersCategoryModel(
        id: id, name: name, logo: logo, photo: photo, date: date);
  }
}
