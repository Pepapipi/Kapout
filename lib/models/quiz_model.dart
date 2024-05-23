import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapout/models/question_model.dart';
import 'package:kapout/repositories/question_repository.dart';

class QuizModel {
  final String? id;
  final String name;
  List<String> questions;
  final int nbContributions;
  String? image;
  final String? bgColor;
  final String? textColor;

  QuizModel({
    this.id,
    required this.name,
    required this.questions,
    this.nbContributions = 0,
    this.image,
    this.bgColor = 'FFFFFF', // Couleur par défaut
    this.textColor = '000000', // Couleur par défaut
  });



  static Future<QuizModel> fromMap(Map<String, dynamic> map, String id) async {
    QuizModel quiz = QuizModel(
      id: id,
      name: map['name'] ,
      image: map['image'] ,
      bgColor: map['bgColor'] ,
      textColor: map['textColor'],
      nbContributions: map['nbContributions'],
      questions:  List<String>.from(map['questions'] ?? []),
    );

    return quiz;

  }

  static Future<QuizModel> fromSnapshot(DocumentSnapshot snapshot) async {
    return await fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }
}