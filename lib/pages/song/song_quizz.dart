import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kapout/components/container_song.dart';
import 'package:kapout/models/quizz_model.dart';
import 'package:kapout/models/song_model.dart';
import 'package:kapout/pages/home/home.dart';
import 'package:kapout/repositories/quizz_repository.dart';
import 'package:kapout/repositories/song_repository.dart';


class SongQuizz extends StatefulWidget {
  String quizzId;
  SongQuizz({Key? key, required this.quizzId}) : super(key: key);

  @override
  State<SongQuizz> createState() => _SongQuizzState();
}

class _SongQuizzState extends State<SongQuizz> {
  late Future<SongModel>? _songModelFuture;
  late List<Future<SongModel>> _songs = []; // Initialiser _songs
  int finalScore = 0;
  int maxPoints = 15;
  int index = 0;
  late SongModel _song;
  late DateTime start;
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _songModelFuture = null;
    Future<QuizzModel> _quizz = QuizzRepository.instance.getQuizz(widget.quizzId);
      _quizz.then((quizz) {
      setState(() { // Mettre à jour l'état de la classe
        _songs = quizz.songs.map<Future<SongModel>>((songId) {
          return SongRepository.instance.getSong(songId);
        }).toList();
        makePage(); // Appeler makePage une fois que _songs est défini
      });
    });
  }

void makePage() async{
    if(index >= _songs.length) {
      audioPlayer.stop();
      print("Score final: $finalScore");
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    }

    _songModelFuture = Future.value(_songs[index]);
    _songModelFuture!.then((songModel) {
      musiquePlayer(songModel.firestoreName);
    }).catchError((error) {
   
      throw Exception("Score final: $finalScore");
    });
  }


Future<void> musiquePlayer(String fileName) async {
  
  final firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);

  // Vérifier que la requête s'est terminée avec succès
   try {
      String downloadURL = await firebaseStorageRef.getDownloadURL();
      audioPlayer.play(UrlSource(downloadURL));
      start = DateTime.now();
      await Future.delayed(const Duration(seconds: 15));
      await audioPlayer.pause();
    }
    // ignore: empty_catches
    catch (e) {
    }
}

Widget proposition(response, proposition) {
  return GestureDetector(
    onTap: () {
      setState(() {
        if(response == proposition) {
          Duration difference = DateTime.now().difference(start);
          int score = maxPoints - difference.inSeconds;
          if(score < 0) {
            score = 1;
          }
          finalScore += score;
        }
        //Passer à la chanson suivante
        index++;
        makePage();
      });
    },
    child: ContainerSong(text: proposition),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: FutureBuilder<SongModel>(
            future: _songModelFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  _song = snapshot.data!;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.headphones,
                        size: 64.0,
                      ),
                      Text(
                        _song.type != 'artist' ? "Trouver le titre de la musique" : "Trouver l'artiste de la musique",
                        style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              proposition(_song.response,_song.propositions[0]),
                              proposition(_song.response,_song.propositions[1]),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              proposition(_song.response,_song.propositions[2]),
                              proposition(_song.response,_song.propositions[3]),
                            ],
                          )
                        ],
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
              }
              return const CircularProgressIndicator();
            },
          )
        )
      )
    );
  }
}
