import 'package:flutter/material.dart';
import 'package:kapout/models/quiz_model.dart';
import 'package:kapout/models/user_quiz_model.dart';
import 'package:kapout/pages/quiz/quiz.dart';

class LaunchQuizButton extends StatelessWidget {
  final Future<QuizModel> quiz;
  final UserQuizModel? userQuiz;

  const LaunchQuizButton({Key? key, required this.quiz, this.userQuiz})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
                  Quiz(quiz: quiz, userQuiz: userQuiz),
            ));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8B2CF5),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('LANCER LE QUIZ',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              Icon(Icons.arrow_forward, color: Colors.white),
            ],
          )),
    );
  }
}
