import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  final String? id;
  final List<String> artists;
  final String songName;
  final List<String> propositions;
  final String response;
  final String type;
  final String firestoreName;

  const QuestionModel({
    this.id,
    required this.artists,
    required this.songName,
    required this.propositions,
    required this.response,
    required this.type,
    required this.firestoreName,
  });

  

  factory SongModel.fromMap(Map<String, dynamic> map, String id) {
    return SongModel(
      id: id,
      artists: List<String>.from(map['artists'] ?? []),
      songName: map['songName'],
      propositions: List<String>.from(map['propositions'] ?? []),
      response: map['response'],
      type: map['type'],
      firestoreName: map['firestoreName'],
    );
  }

  factory SongModel.fromSnapshot(DocumentSnapshot snapshot) {
    return SongModel.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }
}