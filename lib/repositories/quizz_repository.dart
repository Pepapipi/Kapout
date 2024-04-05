import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapout/models/quizz_model.dart';

class QuizzRepository {
  static QuizzRepository get instance => QuizzRepository();
  final _db = FirebaseFirestore.instance;

  Future<List<QuizzModel>> getQuizzs() async {
    final songs = await _db.collection('Quizzs').get();
    return songs.docs.map((e) => QuizzModel.fromSnapshot(e)).toList();
  }

  Future<QuizzModel> getQuizz(String id) async {
    final song = await _db.collection('Songs').doc(id).get();
    return QuizzModel.fromSnapshot(song);
   }

}