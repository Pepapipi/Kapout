import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  String name;
  //Pour Thomas. Ajouter les autres champs nécessaires

  UserModel({
    this.id,
    required this.name,
  }); 

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: map['name'],
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }
}
