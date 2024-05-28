import 'package:flutter/material.dart';
import 'package:kapout/models/quiz_model.dart';
import 'package:kapout/models/user_quiz_model.dart';
import 'package:kapout/pages/quiz/widgets/widget_future_stats.dart';
import 'package:kapout/pages/quiz/widgets/widget_launch_quiz_button.dart';
import 'package:kapout/pages/user/widgets/widget_share.dart';

class FuturePreviewQuiz extends StatelessWidget {

  final String idQuiz;
  final String imageUrl;
  final String name;
  final Future<QuizModel> quizModelFuture;
  final Future<UserQuizModel>? userQuizModelFuture;


  const FuturePreviewQuiz({Key? key, required this.idQuiz, required this.imageUrl, required this.name, required this.quizModelFuture, required this.userQuizModelFuture}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
            future: quizModelFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  QuizModel _quiz = snapshot.data!;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(imageUrl, width: 170, height: 170,),

                          Text(_quiz.name,
                              style: const TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.bold)),
                          Text('Créé par $name',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600])),
                        ],
                      ),
                      LaunchQuizButton(idQuiz: idQuiz),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 22.0),
                            child: Text('Mes stats',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 10),
                          FutureBuilderStatCard(quiz: _quiz, userQuizModelFuture: userQuizModelFuture!),

                        ],
                      ),
                      WidgetShare(),
                    ],
                  );
                }
              }
              return const CircularProgressIndicator();
      }
      );
  }
}