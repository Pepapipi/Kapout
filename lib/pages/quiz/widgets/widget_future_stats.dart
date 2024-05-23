import 'package:flutter/material.dart';
import 'package:kapout/models/quiz_model.dart';
import 'package:kapout/models/user_quiz_model.dart';
import 'package:kapout/pages/quiz/widgets/widget_stat_card.dart';

class FutureBuilderStatCard extends StatelessWidget {

  final QuizModel quiz;
  final Future<UserQuizModel> userQuizModelFuture;

  const FutureBuilderStatCard({Key? key, required this.quiz, required this.userQuizModelFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userQuizModelFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            UserQuizModel _userQuiz = snapshot.data!;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StatCard(
                    title: 'Tentatives',
                    value: _userQuiz.attempts.toString(),
                    image: const AssetImage('assets/redo_512x512.png')),
                const SizedBox(width: 20),
                StatCard(
                  title: 'Meilleur score',
                  value: _userQuiz.bestScore.toString(),
                  image: const AssetImage('assets/flash_512x512.png'),
                  idQuiz: quiz.id,
                  userQuiz: _userQuiz,
                ),
                const SizedBox(width: 20),
                StatCard(
                    title: 'Temps total',
                    value: "${_userQuiz.totalTime}'",
                    image: const AssetImage('assets/chrono_512x512.png')),
              ],
            );
          }
          if(userQuizModelFuture != null)
          {
            return const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StatCard(
                    title: 'Tentatives',
                    value: '0',
                    image: AssetImage('assets/redo_512x512.png')),
                SizedBox(width: 20),
                StatCard(
                    title: 'Meilleur score',
                    value: "0",
                    image: AssetImage('assets/flash_512x512.png')
                    ),
                    
                SizedBox(width: 20),
                StatCard(
                    title: 'Temps total',
                    value: "0",
                    image: AssetImage('assets/chrono_512x512.png')),
              ],
            );
        }
      }
          return const CircularProgressIndicator();

      },
    );
  }
}
