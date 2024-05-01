import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class QuizPreview extends StatefulWidget {
  @override
  _QuizPreviewState createState() => _QuizPreviewState();
}

class _QuizPreviewState extends State<QuizPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        actions: [
          IconButton(
        icon: Icon(Icons.settings_rounded,size: 30,),
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
              const Text('Quiz TEST',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8B2CF5),
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
                  statCard('Tentatives', '2', AssetImage('assets/redo_512x512.png')),
                  SizedBox(width: 20),
                  statCard('Meilleur score', '1200', AssetImage('assets/flash_512x512.png')),
                  SizedBox(width: 20),
                  statCard('Temps total', "5'", AssetImage('assets/chrono_512x512.png')),
                ],
              ),
            ],
          ),
           Padding(
            padding: EdgeInsets.all(22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.ios_share_rounded, color: Color(0xFF8B2CF5), size: 30.0),
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

Widget statCard(String title, String value, AssetImage image) {
  return Container(
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
        SizedBox(height: 10),
        Text(value,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    ),
  );
}
