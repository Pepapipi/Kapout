import 'package:cloud_firestore/cloud_firestore.dart';

class UserQuizModel {
  final String? id;
  String idUser; 
  String idQuiz;
  int bestScore;
  int attempts;
  int totalTime;

  UserQuizModel({
    this.id,
    required this.idUser,
    required this.idQuiz,
    required this.bestScore,
    required this.attempts,
    required this.totalTime,
  });

  factory UserQuizModel.fromMap(Map<String, dynamic> map, String id) {
    return UserQuizModel(
      id: id,
      idUser: map['idUser'],
      idQuiz: map['idQuiz'],
      bestScore: map['bestScore'],
      attempts: map['attempts'],
      totalTime: map['totalTime'],
    );
  }

   factory UserQuizModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserQuizModel.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }

  Future<String> getUsername() async {
    // Assuming you have a collection named 'users' in Firestore
    final userDoc = await FirebaseFirestore.instance.collection('User').doc(idUser).get();
    final userData = userDoc.data();
    final username = userData?['name'] as String;
    return username;
  }
}