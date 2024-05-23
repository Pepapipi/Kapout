import 'package:flutter/material.dart';
import 'package:kapout/models/user_quiz_model.dart';
import 'package:kapout/pages/rank/ranking_quiz.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final ImageProvider image;
  final String? idQuiz;
  final UserQuizModel? userQuiz;

  const StatCard({Key? key, required this.title,required this.value, required this.image, this.idQuiz, this.userQuiz}): super(key: key);
      
  @override
  Widget build(BuildContext context) {
      return GestureDetector(
    onTap: () {
      if (idQuiz != null) {
        Navigator.of(context!).push(MaterialPageRoute(
            builder: (BuildContext context) => RankingQuiz(userQuiz: userQuiz, idQuiz: idQuiz!)));
      }
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
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    ),
  );
  }
}