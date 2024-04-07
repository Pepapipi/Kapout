import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kapout/constants.dart';
import 'package:kapout/models/quizz_model.dart';
import 'package:kapout/pages/song/song_quizz.dart';
import 'package:kapout/repositories/quizz_repository.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<QuizzModel>> _quizzs;
  late List<QuizzModel> _quizz;

  @override
  void initState() {
    super.initState();
    _quizzs = QuizzRepository.instance.getQuizzs();
  }


Widget containerTest(String name, String nbQuestions, String quizzId) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SongQuizz(quizzId: quizzId)));
    },
    child: Container(
      height: 80,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(1),
            spreadRadius: 1,
            blurRadius: 1,
            // changes position of shadow
          ),
        ],
      ),
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: champagePink_900,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Icon(
                    PhosphorIconsBold.vinylRecord,
                    color: Colors.white,
                    size: 35.0,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:  const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$nbQuestions questions',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.play_arrow,
                color: Colors.grey,
              ),
            ],
          )),
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
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
                    color: lightSteelBlue_600,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
              ),
              const Positioned(
                  top: 50,
                  left: 20,
                  child: Text('Bonjour Pepapipi',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 80,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dernier quizz',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            'Quizz 1',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Text("Live Quizz",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder(
            future: _quizzs,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  _quizz = snapshot.data as List<QuizzModel>;
                  return Column(
                    children: _quizz.map((quizz) {
                      return Column(
                        children: [
                          containerTest(
                            quizz.name,
                            quizz.songs.length.toString(),
                            quizz.id!,
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    }).toList(),
                  );
                }
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
