import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kapout/constants.dart';
import 'package:kapout/models/user_quiz_model.dart';
import 'package:kapout/pages/quiz/widgets/widget_padding_back.dart';
import 'package:kapout/pages/quiz/widgets/widget_padding_crown.dart';
import 'package:kapout/pages/quiz/widgets/widget_padding_ranking.dart';
import 'package:kapout/repositories/user_quiz_repository.dart';

class QuizFinalScore extends StatefulWidget {
  final int score;
  final int totalTime;
  final String idQuiz;


  QuizFinalScore({super.key, required this.score, required this.totalTime, required this.idQuiz});

  @override
  State<QuizFinalScore> createState() => _QuizFinalScoreState();
}

class _QuizFinalScoreState extends State<QuizFinalScore> {
  UserQuizModel? userQuiz ;

  @override
  void initState() {
    super.initState();
    UserQuizRepository.instance.getUserQuiz(FirebaseAuth.instance.currentUser!.uid, widget.idQuiz).then((value) {

      userQuiz = value;
      widget.score > userQuiz!.bestScore! ? userQuiz!.bestScore = widget.score : userQuiz!.bestScore = userQuiz!.bestScore;
      userQuiz!.totalTime = widget.totalTime;
      userQuiz!.attempts = userQuiz!.attempts + 1;

      //On enregistre le UserQuizModel
      UserQuizRepository.instance.saveUserQuiz(userQuiz!);
setState(() {
      userQuiz = userQuiz;
    });
    },).catchError((error) {
        userQuiz = UserQuizModel(
        idUser: FirebaseAuth.instance.currentUser!.uid,
        idQuiz: widget.idQuiz,
        bestScore: widget.score,
        totalTime: widget.totalTime,
        attempts: 1
      );
      //On enregistre le UserQuizModel
      UserQuizRepository.instance.saveUserQuiz(userQuiz!);
setState(() {
      userQuiz = userQuiz;
    });
    });

    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
                  image: AssetImage('assets/crown_512x512.png'),
                  width: 250,
                  height: 250,
            ),
              PaddingCrown(score: widget.score),
              PaddingBack(),
              PaddingRanking(idQuiz: widget.idQuiz, userQuiz: userQuiz!),
      
          ],
        ),
      ),
    );
  }
}
