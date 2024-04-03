import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kapout/components/container_song.dart';
import 'package:kapout/models/song_model.dart';
import 'package:kapout/repositories/song_repository.dart';


class SongQuizz extends StatefulWidget {
  const SongQuizz({Key? key}) : super(key: key);

  @override
  State<SongQuizz> createState() => _SongQuizzState();
}

class _SongQuizzState extends State<SongQuizz> {
  late Future<SongModel> _songModelFuture;
  SongModel? _song;
  DateTime start = DateTime.now();
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _songModelFuture = SongRepository.instance.getSong("OCnVIKTDi5wZzs7WLsJK");
    _songModelFuture.then((songModel) {
      musiquePlayer(songModel.firestoreName);
    });   
  }

Future<void> musiquePlayer(String fileName) async {
  
  final firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);

  // Vérifier que la requête s'est terminée avec succès
   try {
      String downloadURL = await firebaseStorageRef.getDownloadURL();
      audioPlayer.play(UrlSource(downloadURL));
      await Future.delayed(const Duration(seconds: 10));
      await audioPlayer.pause();

    }
    // ignore: empty_catches
    catch (e) {
    }
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
                  _song = snapshot.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.headphones,
                        size: 64.0,
                      ),
                      Text(
                        _song?.type != 'artist' ? "Trouver le titre de la musique" : "Trouver l'artiste de la musique",
                        style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ContainerSong(text: _song?.propositions[0] ?? ""),
                              ContainerSong(text: _song?.propositions[1] ?? ""),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ContainerSong(text: _song?.propositions[2] ?? ""),
                              ContainerSong(text: _song?.propositions[3] ?? ""),
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
