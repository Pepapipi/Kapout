import 'package:flutter/material.dart';
import 'package:kapout/components/question_container.dart';
import 'package:kapout/constants.dart';

class StackQuestion extends StatelessWidget {

  final String text;
  final int index;
  final int questionsLength;

  const StackQuestion({Key? key, required this.text, required this.index, required this.questionsLength}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
     return Stack(
    children: [
      Container(
        height: 300.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
        ),
      ),
      Container(
        height: 150.0,
        decoration: const BoxDecoration(
            color: primaryColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
      ),
      Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: QuestionContainer(text: text, index: index.toString(), total: questionsLength.toString(),
        ),
        )
      )
    ],
  );
  }
}