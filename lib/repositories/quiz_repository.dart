import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapout/models/quiz_model.dart';

class QuizRepository {
  static QuizRepository get instance => QuizRepository();
  final _db = FirebaseFirestore.instance;

  Future<List<Future<QuizModel>>> allQuizz() async {
    final quizzs = await _db.collection('Quiz').get();
    return quizzs.docs.map((e) => QuizModel.fromSnapshot(e)).toList();
  }

  Future<QuizModel> getQuizz(String id) async {
    final quizz = await _db.collection('Quiz').doc(id).get();
    return QuizModel.fromSnapshot(quizz);
   }

}