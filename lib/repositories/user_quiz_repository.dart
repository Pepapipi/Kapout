import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kapout/models/user_model.dart';
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
  
  Future<List<UserQuizModel>> getTopPlayers() async {
    final topPlayers = await _db.collection('UserQuiz')
      .orderBy('bestScore', descending: true)
      .limit(10)
      .get();
    return topPlayers.docs.map((doc) => UserQuizModel.fromSnapshot(doc)).toList();
  }

  Future<int> getPositionPlayer(idUser,idQuizz) async {
    final arrayUserQuiz = await _db.collection('UserQuiz')
      .where('idQuiz', isEqualTo: idQuizz)
      .orderBy('bestScore', descending: true)
      .get();

    final userQuiz = await _db.collection('UserQuiz').where('idQuiz', isEqualTo: idQuizz).where('idUser', isEqualTo: idUser).get();

    final position = arrayUserQuiz.docs.indexWhere((doc) => doc.id == userQuiz.docs.first.id) + 1;
    print(position);
    return position;
  }

  //Cette fonction n'est pas censé être ici, mais dans le repository User
  //Sauf que je veux laisser Thomas le faire
  Future<UserModel> getUser(idUser) async {
    final userDoc = await _db.collection('User').doc(idUser).get();
    return UserModel.fromSnapshot(userDoc);
  }
}