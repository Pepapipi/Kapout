import 'package:flutter/material.dart';
import 'package:kapout/constants.dart';
import 'package:kapout/pages/home/home.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SongFinalScore extends StatelessWidget {
  final int score;

  SongFinalScore({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightSteelBlue_300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(
              PhosphorIconsBold.handsClapping,
              size: 100.0,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    'Félicitations !',
                    style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Score final',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: champagePink_600,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$score',
                      style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: lightSteelBlue_600),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                  Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (BuildContext context) =>  const HomePage()));
                // Code pour revenir au menu
              },
              child: const Text('Revenir au menu'),
            ),
          ],
        ),
      ),
    );
  }
}
