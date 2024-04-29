import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapout/models/artist_model.dart';

class SongModel {
  final String? id;
  final List<ArtistModel> artists;
  final String name;
  final String? url;

  const SongModel({
    this.id,
    required this.artists,
    required this.name,
    this.url
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