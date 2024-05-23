import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kapout/bottom_app_bar.dart';
import 'package:kapout/models/quiz_model.dart';
import 'package:kapout/models/user_quiz_model.dart';
import 'package:kapout/pages/quiz/quiz.dart';
import 'package:kapout/pages/quiz/widget_launch_quiz_button.dart';
import 'package:kapout/pages/quiz/widget_stat_card.dart';
import 'package:kapout/repositories/user_quiz_repository.dart';

class QuizPreview extends StatefulWidget {
  final Future<QuizModel> quiz;

  const QuizPreview({Key? key, required this.quiz}) : super(key: key);

  @override
  _QuizPreviewState createState() => _QuizPreviewState();
}

class _QuizPreviewState extends State<QuizPreview> {
  late QuizModel _quiz;
  late Future<UserQuizModel> userQuizFuture;
  late UserQuizModel? userQuiz;

  @override
  void initState() {
    super.initState();
    widget.quiz.then((quiz) {
      setState(() {
        _quiz = quiz;
        getStats();
      });
    }).catchError((error) {
      print("Error fetching quiz: $error");
      // Handle error accordingly, e.g., show an error message
    });
  }

  void getStats() async {
    userQuizFuture = UserQuizRepository.instance
        .getUserQuiz(FirebaseAuth.instance.currentUser!.uid, _quiz.id!);
    userQuizFuture.then((value) => userQuiz = value).catchError((error) {
      userQuiz = null;
      print("Error fetching user quiz: $error");
    });
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
      body: Column(
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
          LaunchQuizButton(quiz: widget.quiz, userQuiz: userQuiz),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 22.0),
                child: Text('Mes stats',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                future: userQuizFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserQuizModel _userQuiz = snapshot.data!;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StatCard(title: 'Tentatives', value:  _userQuiz.attempts.toString(), image: const AssetImage('assets/redo_512x512.png')),
                          const SizedBox(width: 20),
                          StatCard(title: 'Temps total',value: _userQuiz.bestScore.toString(), image: const AssetImage('assets/flash_512x512.png'),idQuiz:  _quiz.id,  userQuiz: userQuiz,),
                          const SizedBox(width: 20),
                          StatCard(title: 'Temps total', value: "${_userQuiz.totalTime}'", image: const AssetImage('assets/chrono_512x512.png')),
                        ],
                      );
                    }
                     return const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StatCard(title: 'Tentatives', value: 'Erreur', image: AssetImage('assets/redo_512x512.png')),
                          SizedBox(width: 20),
                          StatCard(title: 'Temps total',value: "ERREUR", image:  AssetImage('assets/flash_512x512.png')),
                          SizedBox(width: 20),
                          StatCard(title: 'Temps total', value: "ERREUR", image:  AssetImage('assets/chrono_512x512.png')),
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
      ),
    );
  }
}

