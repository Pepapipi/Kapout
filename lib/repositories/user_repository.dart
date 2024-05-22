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
    await _db.collection('User').add(
      {
        'id': userId,
        'name': userName,
        'mail': userMail,
        'icon': '', // mettre une icone par défaut
        'idLeague': '',
        'idCumul': '',
        'quizzTotal': 0,
        'xpTotal': 0,
        'timeTotal': 0
      });
  }

}