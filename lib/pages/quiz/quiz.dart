import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kapout/components/container_song.dart';
import 'package:kapout/models/question_model.dart';
import 'package:kapout/models/quiz_model.dart';
import 'package:kapout/pages/quiz/quiz_final_score.dart';


class Quiz extends StatefulWidget {
  Future<QuizModel> quiz;
  Quiz({Key? key, required this.quiz}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizzState();
}

class _QuizzState extends State<Quiz> {
  late Future<QuestionModel>? _questionFuture;
   
  List<QuestionModel> _questions = []; // Initialiser _songs
  int finalScore = 0;
  int maxPoints = 30;
  int index = 0;

  late QuestionModel _question;
  late DateTime start = DateTime.now();
  final audioPlayer = AudioPlayer();

@override
void initState() {
  super.initState();
  _questionFuture = null;
  widget.quiz.then((quiz) {
    setState(() {
      _questions = quiz.questions;
      makePage();
    });
  }).catchError((error) {
    print("Error fetching quiz: $error");
    // Handle error accordingly, e.g., show an error message
  });
}

void makePage() async{
    if(index >= _questions.length) {
      audioPlayer.stop();
      print("Score final: $finalScore");
      Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (BuildContext context) =>  QuizFinalScore(score: finalScore)));
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
      await Future.delayed(const Duration(seconds: 15));
      await audioPlayer.pause();
    }
    // ignore: empty_catches
    catch (e) {
    }
}

Widget proposition(response, proposition) {
  return GestureDetector(
    onTap: () {
      setState(() {
        if(response == proposition) {
          Duration difference = DateTime.now().difference(start);
          int score = maxPoints - difference.inSeconds;
          if(score < 0) {
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: FutureBuilder<QuestionModel>(
            future: _questionFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  _question = snapshot.data!;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.headphones,
                        size: 64.0,
                      ),
                      Text(
                        _question.type != 'artist' ? "Trouver le titre de la musique" : "Trouver l'artiste de la musique",
                        style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              proposition(_question.answer,_question.propositions[0]),
                              proposition(_question.answer,_question.propositions[1]),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              proposition(_question.answer,_question.propositions[2]),
                              proposition(_question.answer,_question.propositions[3]),
                            ],
                          )
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
          )
        )
      )
    );
  }
}
