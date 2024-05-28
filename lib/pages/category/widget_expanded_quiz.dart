import 'package:flutter/material.dart';
import 'package:kapout/models/quiz_model.dart';
import 'package:kapout/pages/category/widget_select_quiz.dart';

class ExpandedQuiz extends StatelessWidget {
  List<QuizModel> quizzes;
  List<String> images;

  ExpandedQuiz({required this.quizzes, required this.images});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // Nombre de colonnes
          crossAxisSpacing: 2, // Espacement horizontal entre les colonnes
          mainAxisSpacing: 2, // Espacement vertical entre les lignes
          childAspectRatio: 8 / 2, //Ratio entre hauteur/largeur des rectangles
        ),
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          return SelectQuiz(
              idQuiz: quizzes[index].id!,
              name: quizzes[index].name,
              image: images[index],
              bgColor: quizzes[index].bgColor!,
              textColor: quizzes[index].textColor!);
        },
      ),
    );
  }
}
