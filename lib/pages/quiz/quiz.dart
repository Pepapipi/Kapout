import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kapout/components/container_song.dart';
import 'package:kapout/models/question_model.dart';
import 'package:kapout/models/quiz_model.dart';
import 'package:kapout/models/user_quiz_model.dart';
import 'package:kapout/pages/quiz/quiz_final_score.dart';
import 'package:kapout/pages/quiz/widget_stack_question.dart';
import 'package:kapout/repositories/question_repository.dart';

class Quiz extends StatefulWidget {
  Future<QuizModel> quiz;
  UserQuizModel? userQuiz;
  Quiz({Key? key, required this.quiz, required this.userQuiz}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizzState();
}

class _QuizzState extends State<Quiz> {
  late Future<QuestionModel>? _questionFuture;
  UserQuizModel? userQuiz;

  List<QuestionModel> _questions = []; // Initialiser _songs
  int finalScore = 0;
  int maxPoints = 30;
  int index = 0;

  late QuestionModel _question;
  late QuizModel quiz;
  late DateTime start;
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    start = DateTime.now();
    userQuiz = widget.userQuiz;
    _questionFuture = null;
    widget.quiz.then((quiz) {

      List<QuestionModel> questions = [];
      for (String idQuestion in quiz.questions) {
        QuestionRepository.instance.getQuestion(idQuestion).then((question) {
          questions.add(question);
        });
      }

      setState(() {
        this.quiz = quiz;
        _questions = questions;
        makePage();
      });
    }).catchError((error) {
    });
  }

  void makePage() async {
    audioPlayer.stop();
    if (index >= _questions.length) {

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
                QuizFinalScore(score: finalScore, userQuiz: userQuiz , idQuiz: quiz.id!, totalTime:   DateTime.now().difference(start).inSeconds)));
          }
    _questionFuture = Future.value(_questions[index]);
    _questionFuture!.then((questionModel) {
      musiquePlayer(questionModel.song.url, questionModel.startTime);
    }).catchError((error) {
      throw Exception("Score final: $finalScore");
    });
  }

  Future<void> musiquePlayer(String fileName, int startTime) async {
    final firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);

    // Vérifier que la requête s'est terminée avec succès
    try {
      String downloadURL = await firebaseStorageRef.getDownloadURL();
      audioPlayer.seek(Duration(seconds: startTime));
      audioPlayer.play(UrlSource(downloadURL));
      start = DateTime.now();
    } catch (e) {
      print('Erreur lors de la lecture du fichier audio : $e');
    }
  }

  Widget proposition(response, proposition) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (response == proposition) {
            Duration difference = DateTime.now().difference(start);
            int score = maxPoints - difference.inSeconds;
            if (score < 0) {
              score = 1;
            }
            finalScore += score;
          }
          //Passer à la chanson suivante
          index++;
          makePage();
        });
      },
      child: ContainerSong(text: proposition),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: FutureBuilder<QuestionModel>(
      future: _questionFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            _question = snapshot.data!;
            return Column(
              children: [
                StackQuestion(text:  _question.type != 'artist'
                    ? "Trouver le titre de la musique"
                    : "Trouver l'artiste de la musique",
                    index: index + 1, questionsLength:  _questions.length),
                Column(
                  children: [
                    proposition(_question.answer, _question.propositions[0]),
                    proposition(_question.answer, _question.propositions[1]),
                    proposition(_question.answer, _question.propositions[2]),
                    proposition(_question.answer, _question.propositions[3]),
                  ],
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
        }
        return const CircularProgressIndicator();
      },
    ));
  }
}

