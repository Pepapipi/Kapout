import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapout/models/artist_model.dart';

class CategoryRepository {

  static CategoryRepository get instance => CategoryRepository();
  final _db = FirebaseFirestore.instance;
  
  Future<List<ArtistModel>> allCategories() async {
    final artists = await _db.collection('Category').get();
    return artists.docs.map((e) => ArtistModel.fromSnapshot(e)).toList();
  }

  
  Future<ArtistModel> getCategory(String id) async {
  final artist = await _db.collection('Category').doc(id).get();
  return ArtistModel.fromSnapshot(artist);
  }


}