import 'package:cloud_firestore/cloud_firestore.dart';

class QuizzModel{
  final String? id;
  final String name;
  List<String> songs;

  QuizzModel({
    this.id,
    required this.name,
    required this.songs,
  });

    factory QuizzModel.fromMap(Map<String, dynamic> map, String id) {
    return QuizzModel(
      id: id,
      name: map['name'],
      songs: List<String>.from(map['songs'] ?? []),
    );
  }

  factory QuizzModel.fromSnapshot(DocumentSnapshot snapshot) {
    return QuizzModel.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }

}