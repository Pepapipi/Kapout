import 'package:flutter/material.dart';
import 'package:kapout/models/user_quiz_model.dart';
import 'package:kapout/pages/rank/ranking_quiz.dart';

class PaddingRanking extends StatelessWidget {

  final String idQuiz;
  final UserQuizModel userQuiz;

  const PaddingRanking({Key? key, required this.idQuiz, required this.userQuiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => RankingQuiz(
                    userQuiz: userQuiz,
                    idQuiz: idQuiz,
                  )));
        },
        child: const Center(
            child: Text(
          "Voir le classement",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
