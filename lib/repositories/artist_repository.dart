import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapout/models/artist_model.dart';

class ArtistRepository {

  static ArtistRepository get instance => ArtistRepository();
  final _db = FirebaseFirestore.instance;
  
  Future<List<ArtistModel>> allArtists() async {
    final artists = await _db.collection('Artist').get();
    return artists.docs.map((e) => ArtistModel.fromSnapshot(e)).toList();
  }

  
  Future<ArtistModel> getArtist(String id) async {
  final artist = await _db.collection('Artist').doc(id).get();
  return ArtistModel.fromSnapshot(artist);
  }


}