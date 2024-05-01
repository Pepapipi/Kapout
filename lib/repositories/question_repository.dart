import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapout/models/question_model.dart';



class QuestionRepository {

  static QuestionRepository get instance => QuestionRepository();
  final _db = FirebaseFirestore.instance;
  
  Future<List<Future<QuestionModel>>> allQuestions() async {
    final questions = await _db.collection('Question').get();
    return questions.docs.map((e) => QuestionModel.fromSnapshot(e)).toList();
  }

  /*Future<Map<String, dynamic>> getSong(String id) async {
    final song = await _db.collection('songs').doc(id).get();
    return song.data()!;
  }*/

  
   Future<QuestionModel> getQuestion(String id) async {
    final question = await _db.collection('Question').doc(id).get();
    return QuestionModel.fromSnapshot(question);
   }



}