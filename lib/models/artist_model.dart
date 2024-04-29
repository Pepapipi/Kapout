import 'package:cloud_firestore/cloud_firestore.dart';

class ArtistModel{
  final String? id;
  final String name;
  final String? picture;

  ArtistModel({
    this.id,
    required this.name,
    this.picture,
  });

    factory ArtistModel.fromMap(Map<String, dynamic> map, String id) {
    return ArtistModel(
      id: id,
      name: map['name'],
      picture: map['picture'],
    );
  }

  factory ArtistModel.fromSnapshot(DocumentSnapshot snapshot) {
    return ArtistModel.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }
}