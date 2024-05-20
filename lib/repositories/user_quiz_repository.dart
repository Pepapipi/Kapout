import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapout/models/user_quiz_model.dart';

class UserQuizRepository {

   static UserQuizRepository get instance => UserQuizRepository();
  final _db = FirebaseFirestore.instance;

  Future<UserQuizModel> getUserQuiz(String idUser, String idQuiz) async {
    final userQuiz = await _db.collection('UserQuiz')
      .where('idUser', isEqualTo: idUser)
      .where('idQuiz', isEqualTo: idQuiz)
      .get();
    return UserQuizModel.fromSnapshot(userQuiz.docs.first);
  }
}