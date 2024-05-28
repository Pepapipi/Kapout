import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapout/models/user_model.dart';

class UserRepository {

   static UserRepository get instance => UserRepository();
  final _db = FirebaseFirestore.instance;
  
  Future<UserModel> getUser(idUser) async {
    final userDoc = await _db.collection('User').doc(idUser).get();
    return UserModel.fromSnapshot(userDoc);
  }

  Future<void> createUser(String userId, String userName, String userMail) async {
    await _db.collection('User').doc(userId).set(
      {
        'name': userName,
        'mail': userMail,
        'icon': '', // mettre une icone par défaut
        'idLeague': '',
        'idCumul': '',
        'quizzTotal': 0,
        'xpTotal': 0,
        'timeTotal': 0,
        'createdAt': FieldValue.serverTimestamp(),
      });
  }

  Future<void> updateUsername(String userId, String userName) async {
    if(await checkNameExist(userName) == false){
      await _db.collection('User').doc(userId).update({'name': userName});
    }
  }

  Future<bool> checkNameExist(String userName) async {
    final userDoc = await _db.collection('User').where('name', isEqualTo: userName).get();
    return userDoc.docs.isNotEmpty;
  }

  Future<void> updateStats(int finishQuiz, int xp, int time, String userId) async {
    final userDoc = await _db.collection('User').doc(userId).get();
    final user = UserModel.fromSnapshot(userDoc);
    await _db.collection('User').doc(userId).update({
      'quizzTotal': user.quizzTotal + finishQuiz,
      'xpTotal': user.xpTotal + xp,
      'timeTotal': user.timeTotal + time,
    });
  }
} 