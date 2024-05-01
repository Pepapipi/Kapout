import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapout/models/song_model.dart';
import 'package:kapout/repositories/song_repository.dart';

class QuestionModel {
  final String? id;
  SongModel song;
  final List<String> propositions;
  final String answer;
  final String type;
  final int startTime;

  QuestionModel({
    this.id,
    required this.song,
    required this.propositions,
    required this.answer,
    required this.type,
    required this.startTime
  });

  static Future<QuestionModel> _initialize(QuestionModel question,  List<String> questionsData) async {

    for (String songId in questionsData) {
      try {
        SongModel song =
            await SongRepository.instance.getSong(songId);
        question.song = song;
      } catch (error) {
        print("Error fetching question: $songId - $error");
        // You can also consider re-throwing the error or handling it differently
      }
    }
    return question;
  }


  static Future<QuestionModel> fromMap(Map<String, dynamic> map, String id) async {

    return QuestionModel(
      id: id,
      song:  await SongRepository.instance.getSong(map['song']),
      propositions: List<String>.from(map['propositions'] ?? []),
      answer: map['answer'],
      type: map['type'],
      startTime: map['startTime']
    );
  }

  static Future<QuestionModel> fromSnapshot(DocumentSnapshot snapshot) async {
    return await QuestionModel.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }
}