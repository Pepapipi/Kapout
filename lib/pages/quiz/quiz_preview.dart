import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kapout/bottom_app_bar.dart';
import 'package:kapout/models/quiz_model.dart';
import 'package:kapout/models/user_quiz_model.dart';
import 'package:kapout/pages/quiz/quiz.dart';
import 'package:kapout/pages/quiz/widget_launch_quiz_button.dart';
import 'package:kapout/pages/quiz/widget_stat_card.dart';
import 'package:kapout/repositories/quiz_repository.dart';
import 'package:kapout/repositories/user_quiz_repository.dart';

class QuizPreview extends StatefulWidget {
  final String idQuiz;

  const QuizPreview({Key? key, required this.idQuiz}) : super(key: key);

  @override
  _QuizPreviewState createState() => _QuizPreviewState();
}

class _QuizPreviewState extends State<QuizPreview> {
  late QuizModel _quiz;
  Future<UserQuizModel>? userQuizModelFuture;
  Future<QuizModel>? quizModelFuture;

  @override
  void initState() {
    super.initState();
    userQuizModelFuture = UserQuizRepository.instance.getUserQuiz(FirebaseAuth.instance.currentUser!.uid, widget.idQuiz);
    quizModelFuture = QuizRepository.instance.getQuiz(widget.idQuiz);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomNavigationBarPage(),
        appBar: AppBar(
          title: null,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.settings_rounded,
                size: 30,
              ),
              onPressed: () {
                // Add your share functionality here
              },
            ),
          ],
        ),
        body: FutureBuilder(
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
                          const Image(
                            image: AssetImage('assets/music_disk_512x512.png'),
                            width: 169,
                            height: 169,
                          ),
                          Text(_quiz.name,
                              style: const TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.bold)),
                          Text('Créé par Totouffe',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600])),
                        ],
                      ),
                      LaunchQuizButton(idQuiz: widget.idQuiz),
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
                          FutureBuilder(
                            future: userQuizModelFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  UserQuizModel _userQuiz = snapshot.data!;
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      StatCard(
                                          title: 'Tentatives',
                                          value: _userQuiz.attempts.toString(),
                                          image: const AssetImage(
                                              'assets/redo_512x512.png')),
                                      const SizedBox(width: 20),
                                      StatCard(
                                        title: 'Temps total',
                                        value: _userQuiz.bestScore.toString(),
                                        image: const AssetImage(
                                            'assets/flash_512x512.png'),
                                        idQuiz: _quiz.id,
                                        userQuiz: _userQuiz,
                                      ),
                                      const SizedBox(width: 20),
                                      StatCard(
                                          title: 'Temps total',
                                          value: "${_userQuiz.totalTime}'",
                                          image: const AssetImage(
                                              'assets/chrono_512x512.png')),
                                    ],
                                  );
                                }
                                return const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    StatCard(
                                        title: 'Tentatives',
                                        value: 'Erreur',
                                        image: AssetImage(
                                            'assets/redo_512x512.png')),
                                    SizedBox(width: 20),
                                    StatCard(
                                        title: 'Temps total',
                                        value: "ERREUR",
                                        image: AssetImage(
                                            'assets/flash_512x512.png')),
                                    SizedBox(width: 20),
                                    StatCard(
                                        title: 'Temps total',
                                        value: "ERREUR",
                                        image: AssetImage(
                                            'assets/chrono_512x512.png')),
                                  ],
                                );
                              }

                              return const CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.ios_share_rounded,
                                    color: Color(0xFF8B2CF5), size: 30.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }
              return const CircularProgressIndicator();
      }
      ));
  }
}
