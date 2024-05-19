import 'package:flutter/material.dart';
import 'package:kapout/constants.dart';

class QuestionContainer extends StatelessWidget {
  const QuestionContainer({super.key, required this.text, required this.index, required this.total});
  final String text;
  final String index;
  final String total;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: primaryColor,
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 3),
        ),
      ],
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      child: 
          Center(
          child: Column(
            children: [
              const SizedBox(height: 20), //SizedBox(height: 20
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Question ',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    index,
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '/$total',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(text, style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),  
            ],  
          ),
        ),
    );

  }
}