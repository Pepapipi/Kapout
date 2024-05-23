import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kapout/bottom_app_bar.dart';
import 'package:kapout/models/quiz_model.dart';
import 'package:kapout/models/user_quiz_model.dart';
import 'package:kapout/pages/quiz/quiz.dart';
import 'package:kapout/pages/quiz/widgets/widget_future_preview.dart';
import 'package:kapout/pages/quiz/widgets/widget_future_stats.dart';
import 'package:kapout/pages/quiz/widgets/widget_launch_quiz_button.dart';
import 'package:kapout/pages/quiz/widgets/widget_stat_card.dart';
import 'package:kapout/repositories/quiz_repository.dart';
import 'package:kapout/repositories/user_quiz_repository.dart';
import 'package:kapout/repositories/user_repository.dart';
import 'package:kapout/services/firebase_storage_service.dart';

class QuizPreview extends StatefulWidget {
  final String idQuiz;

  const QuizPreview({Key? key, required this.idQuiz}) : super(key: key);

  @override
  _QuizPreviewState createState() => _QuizPreviewState();
}

class _QuizPreviewState extends State<QuizPreview> {
  Future<UserQuizModel>? userQuizModelFuture;
  Future<QuizModel>? quizModelFuture;
  String imageUrl='';
  String name = 'aaaaaaa'; 

  @override
  void initState()  {
    super.initState();
    userQuizModelFuture = UserQuizRepository.instance.getUserQuiz(FirebaseAuth.instance.currentUser!.uid, widget.idQuiz);
    quizModelFuture = QuizRepository.instance.getQuiz(widget.idQuiz);



    quizModelFuture?.then((value) async {
      await UserRepository.instance.getUser(value.idCreator).then((user) {
        name = user.name;
      });

      await FirebaseStorageService.instance.getAsset(value.image!).then((value) {
        setState(() {
          imageUrl = value;
          name= name;
        });
      });
     
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
        body: FuturePreviewQuiz(idQuiz: widget.idQuiz, imageUrl: imageUrl, name: name,quizModelFuture: quizModelFuture!, userQuizModelFuture: userQuizModelFuture!));
      
  }
}
