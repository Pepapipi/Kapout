import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_podium/flutter_podium.dart';
import 'package:kapout/bottom_app_bar.dart';
import 'package:kapout/constants.dart';
import 'package:kapout/models/user_quiz_model.dart';
import 'package:kapout/pages/rank/widget_top4_top10.dart';
import 'package:kapout/repositories/user_quiz_repository.dart';

class RankingQuiz extends StatefulWidget {
  UserQuizModel? userQuiz;
  String idQuiz;

  RankingQuiz({super.key, required this.userQuiz, required this.idQuiz});

  @override
  State<RankingQuiz> createState() => _RankingQuizState();
}

class _RankingQuizState extends State<RankingQuiz> {

  late List<UserQuizModel> topPlayers = [];
  List<List<dynamic>> bestScores = [];

  List<dynamic> positionPlayer = [];

  @override
  void initState() {
    super.initState();
    _loadRankingData();
  }

   Future<void> _loadRankingData() async {
    try {
      // Charger les meilleurs joueurs
      List<UserQuizModel> topPlayers = await UserQuizRepository.instance.getTopPlayers();
      List<List<dynamic>> bS = [];
      for (var element in topPlayers) {
        String name = await element.getUsername();
        bS.add([name, element.bestScore]);
      }

      // Charger la position du joueur actuel
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      int position = await UserQuizRepository.instance.getPositionPlayer(currentUserId, widget.idQuiz);
      String currentUsername = await widget.userQuiz!.getUsername();
      positionPlayer = [position, currentUsername, widget.userQuiz!.bestScore ?? "0"];

      setState(() {
        this.topPlayers = topPlayers;
        bestScores = bS;
      });
    } catch (e) {
      setState(() {
        positionPlayer = ["VIDE", "VIDE", "VIDE"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: primaryColorLight,
      appBar: AppBar(
      ),
      body: topPlayers.isEmpty ? const CircularProgressIndicator() : Column(
        children: [
          const SizedBox(height: 45,),
           Podium(
                firstPosition: Text(topPlayers.isNotEmpty ? "${bestScores[0][0]} \n ${bestScores[0][1]}" : "VIDE", textAlign: TextAlign.center, style: const TextStyle(color: secondaryColor, fontSize: 20, fontWeight: FontWeight.bold)),
               secondPosition: Text(topPlayers.length > 1 ? "${bestScores[1][0]} \n ${bestScores[1][1]}": "VIDE", textAlign: TextAlign.center, style: const TextStyle(color: secondaryColor, fontSize: 20, fontWeight: FontWeight.bold),),
               thirdPosition: Text(topPlayers.length > 2 ?"${bestScores[2][0]} \n ${bestScores[2][1]}" : "VIDE",textAlign: TextAlign.center, style: const TextStyle(color: secondaryColor, fontSize: 20, fontWeight: FontWeight.bold),),
               color: secondaryColor,
               rankingTextColor: Colors.white,
               rankingFontSize: 30,
               hideRanking: false,
               showRankingNumberInsteadOfText: true,
               height: 250,
               width: 100,
               horizontalSpacing: 3,
             ),

            WidgetTop4Top10(bestScores: bestScores, positionPlayer: positionPlayer),
        ],
      ),
    bottomNavigationBar: const BottomNavigationBarPage(),

    );
  }
}