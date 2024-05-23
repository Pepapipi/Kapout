import 'package:flutter/material.dart';
import 'package:kapout/constants.dart';

class PaddingCrown extends StatelessWidget {
  final int score;

  const PaddingCrown({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            'Félicitations !',
            style: TextStyle(
                fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Totouffe',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            width: 150,
            decoration: BoxDecoration(
              color: yellowCrown,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '$score',
                style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
