import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapout/models/artist_model.dart';
import 'package:kapout/repositories/artist_repository.dart';

class SongModel {
  final String? id;
  final List<ArtistModel> artists;
  final String name;
  final String url;

  const SongModel({
    this.id,
    required this.artists,
    required this.name,
    required this.url
  });


  factory SongModel.fromMap(Map<String, dynamic> map, String id) {

    List<ArtistModel> artists = [];
    map['artists'].forEach((artistRef) {
      ArtistRepository.instance.getArtist(artistRef).then((artist) {
        artists.add(artist);
      });
    });

    return SongModel(
      id: id,
      artists: artists,
      name: map['name'],
      url: map['url'],
    );
  }

  factory SongModel.fromSnapshot(DocumentSnapshot snapshot) {
    return SongModel.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }
}