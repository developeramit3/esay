import 'package:cloud_firestore/cloud_firestore.dart';

class OfferModel {
  final String id;
  final imageUrl;
  final imageCato;
  final String photoName;
  final String name;
  final String description;
  final String category;
  final Timestamp startDate;
  final Timestamp endDate;
  final int likes;
  final String store;
  final int timeCode;

  OfferModel({
    this.imageCato,
    this.id,
    this.imageUrl,
    this.photoName,
    this.name,
    this.description,
    this.category,
    this.startDate,
    this.endDate,
    this.likes,
    this.store,
    this.timeCode,
  });

  factory OfferModel.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    String id = documentId;
    String imageUrl = data['imageUrl'];
    String photoName = data['photoName'];
    String imageCato = data['icon'];
    String name = data['name'];
    String description = data['description'];
    String category = data['category'];
    Timestamp startDate = data['startDate'];
    Timestamp endDate = data['endDate'];
    int likes = data['likes'];
    String store = data['store'];
    int timeCode = data['timeCode'];
    return OfferModel(
        id: id,
        imageUrl: imageUrl,
        imageCato: imageCato,
        photoName: photoName,
        name: name,
        description: description,
        category: category,
        startDate: startDate,
        endDate: endDate,
        likes: likes,
        store: store,
        timeCode: timeCode);
  }
}
