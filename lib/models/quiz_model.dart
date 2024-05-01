import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapout/models/question_model.dart';
import 'package:kapout/repositories/question_repository.dart';

class QuizModel {
  final String? id;
  final String name;
  List<QuestionModel> questions;

  QuizModel({
    this.id,
    required this.name,
    required this.questions,
  });

  static Future<QuizModel> _initialize(QuizModel quiz,  List<String> questionsData) async {
    List<QuestionModel> questions = [];
    for (String questionId in questionsData) {
      try {
        QuestionModel question =
            await QuestionRepository.instance.getQuestion(questionId);
        questions.add(question);
      } catch (error) {
        print("Error fetching question: $questionId - $error");
        // You can also consider re-throwing the error or handling it differently
      }
    }
    quiz.questions = questions;
    return quiz;
  }

  static Future<QuizModel> fromMap(Map<String, dynamic> map, String id) async {
    QuizModel quiz = QuizModel(
      id: id,
      name: map['name'] ?? '',
      questions: [],
    );

    quiz = await _initialize(quiz, List<String>.from(map['questions'] as List<dynamic>));
    return quiz;

  }

  static Future<QuizModel> fromSnapshot(DocumentSnapshot snapshot) async {
    return await fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }
}