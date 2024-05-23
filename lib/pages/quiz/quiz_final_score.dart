import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kapout/constants.dart';
import 'package:kapout/models/user_quiz_model.dart';
import 'package:kapout/pages/category/main_category.dart';
import 'package:kapout/pages/rank/ranking_quiz.dart';
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
    //Si UserQuiz est null, on crée un UserQuizModel
    if (value.id == null) {
      userQuiz = UserQuizModel(
        idUser: FirebaseAuth.instance.currentUser!.uid,
        idQuiz: widget.idQuiz,
        bestScore: widget.score,
        totalTime: widget.totalTime,
        attempts: 1
      );
    } else {
      //Si UserQuiz n'est pas null, on met à jour le score et le temps
      userQuiz = value;
      widget.score > userQuiz!.bestScore! ? userQuiz!.bestScore = widget.score : userQuiz!.bestScore = userQuiz!.bestScore;
      userQuiz!.totalTime = widget.totalTime;
      userQuiz!.attempts = userQuiz!.attempts + 1;
    }

    //On enregistre le UserQuizModel
    UserQuizRepository.instance.saveUserQuiz(userQuiz!);
    },);


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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    'Félicitations !',
                    style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Totouffe',
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: 150,
                    decoration: BoxDecoration(
                      color: yellowCrown,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        '${widget.score}',
                        style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () {
                    Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (BuildContext context) =>  const MainCategory()));
                  ;
                    },
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text(
                                  "Revenir au menu",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold),
                                )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => RankingQuiz(userQuiz: userQuiz,idQuiz: widget.idQuiz,)));
                  
                    },

                      child: const Center(
                          child: Text(
                                  "Voir le classement",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                      ),
                                )),
                    ),
                  ),
                
          ],
        ),
      ),
    );
  }
}
