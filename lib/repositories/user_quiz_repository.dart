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

  Future<void> saveUserQuiz(UserQuizModel userQuiz) async {
    if (userQuiz.id == null) {
      await _db.collection('UserQuiz').add(
        {
        'idUser': userQuiz.idUser,
        'idQuiz': userQuiz.idQuiz,
        'bestScore': userQuiz.bestScore,
        'attempts': userQuiz.attempts,
        'totalTime': userQuiz.totalTime,
      });
    } else {
      await _db.collection('UserQuiz').doc(userQuiz.id).update({
        'bestScore': userQuiz.bestScore,
        'attempts': userQuiz.attempts,
        'totalTime': userQuiz.totalTime,
      });
    }
  }
}