import 'package:flutter/material.dart';

class AppBarQuizCategorie extends StatelessWidget {

  final String name;

  const AppBarQuizCategorie({super.key, required this.name});


  @override
  Widget build(BuildContext context) {
    return AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30, // Taille de la police
                  ),
                ),
                Image.asset('assets/flag_256x256.png',  width: 50, height: 50),
              ],
            ),
          ),

        );
  }
}