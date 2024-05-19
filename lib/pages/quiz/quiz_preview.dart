import 'package:flutter/material.dart';
import 'package:kapout/bottom_app_bar.dart';
import 'package:kapout/models/quiz_model.dart';
import 'package:kapout/pages/home/home.dart';
import 'package:kapout/pages/quiz/quiz.dart';
import 'package:kapout/pages/rank/ranking_quiz.dart';

class QuizPreview extends StatefulWidget {
  final Future<QuizModel> quiz;

  const QuizPreview({Key? key, required this.quiz}) : super(key: key);

  @override
  _QuizPreviewState createState() => _QuizPreviewState();
}

class _QuizPreviewState extends State<QuizPreview> {
  late QuizModel _quiz;

  @override
  void initState() {
    super.initState();
    widget.quiz.then((quiz) {
      setState(() {
        _quiz = quiz;
      });
    }).catchError((error) {
      print("Error fetching quiz: $error");
      // Handle error accordingly, e.g., show an error message
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarPage(),
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
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              Text('Créé par Totouffe',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600])),
            ],
          ),
          SizedBox(
            width: 210,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Quiz(quiz: widget.quiz),));
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
          ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  statCard(
                      'Tentatives', '2', const AssetImage('assets/redo_512x512.png'),false,context),
                  const SizedBox(width: 20),
                  statCard('Meilleur score', '1200',
                      const AssetImage('assets/flash_512x512.png'),true,context),
                  const SizedBox(width: 20),
                  statCard('Temps total', "5'",
                      const AssetImage('assets/chrono_512x512.png'),false,context),
                ],
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
                    padding:  EdgeInsets.all(8.0),
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

Widget statCard(String title, String value, AssetImage image, bool openClassement, BuildContext context) {
  return GestureDetector(
    onTap: () {
      if(openClassement) {
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => RankingQuiz()));      }
      // Add your stat card functionality here
    },
    child: Container(
      width: 100,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFABABAB)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image(image: image, width: 50, height: 50),
          const SizedBox(height: 10),
          Text(value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    ),
  );
}
