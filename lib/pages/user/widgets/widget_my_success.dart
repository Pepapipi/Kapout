import 'package:flutter/material.dart';
import 'package:kapout/models/user_model.dart';
import 'package:kapout/pages/user/userProfile.dart';

class WidgetMySuccess extends StatelessWidget {

  UserModel userProfile;

  WidgetMySuccess({super.key, required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 22.0),
            child: Text('Mes succès',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              statCard(
                'Quizz terminés',
                userProfile.quizzTotal.toString(),
                const AssetImage('assets/musical_note_512x512.png'),
              ),
              const SizedBox(width: 20),
              statCard(
                'XP gagnés',
                userProfile.xpTotal.toString(), //"${_userProfile.xpTotal}'",
                const AssetImage('assets/flash_512x512.png'),
              ),
              const SizedBox(width: 20),
              statCard(
                'Temps total',
                userProfile.timeTotal.toString(), //"${_userProfile.timeTotal}'",
                const AssetImage('assets/chrono_512x512.png'),
              ),
            ],
          )
        ]);
  }
}

Widget statCard(String title, String value, AssetImage image) {
  return GestureDetector(
    onTap: () {
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