import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapout/models/song_model.dart';

class SongRepository {

  static SongRepository get instance => SongRepository();
  final _db = FirebaseFirestore.instance;
  
  Future<List<SongModel>> getSongs() async {
    final songs = await _db.collection('Songs').get();
    return songs.docs.map((e) => SongModel.fromSnapshot(e)).toList();
  }

  Future<void> addSong(Map<String, dynamic> song) async {
    await _db.collection('Songs').add(song);
  }

  Future<void> updateSong(String id, Map<String, dynamic> song) async {
    await _db.collection('Songs').doc(id).update(song);
  }

  Future<void> deleteSong(String id) async {
    await _db.collection('Songs').doc(id).delete();
  }

  /*Future<Map<String, dynamic>> getSong(String id) async {
    final song = await _db.collection('songs').doc(id).get();
    return song.data()!;
  }*/

   Future<SongModel> getSong(String id) async {
    final song = await _db.collection('Songs').doc(id).get();
    return SongModel.fromSnapshot(song);
   }
}