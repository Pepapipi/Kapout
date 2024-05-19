
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_podium/flutter_podium.dart';
import 'package:kapout/bottom_app_bar.dart';
import 'package:kapout/constants.dart';

class RankingQuiz extends StatefulWidget {
  @override
  _RankingQuizState createState() => _RankingQuizState();
}

class _RankingQuizState extends State<RankingQuiz> {
  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> players = [
      ["James", 91],
      ["Steinfield", 90],
      ["Icona", 80],
      ["James", 70],
      ["James", 60],
      ["Steinfield", 50],
      ["Icona", 40],
    ];
    
    return Scaffold(
      backgroundColor: primaryColorLight,
      appBar: AppBar(
      ),
      body:  Column(
        children: [
          const SizedBox(height: 45,),
          const Podium(
               firstPosition: Text("Pepapipi \n 182", textAlign: TextAlign.center, style: TextStyle(color: secondaryColor, fontSize: 20, fontWeight: FontWeight.bold),),
               secondPosition: Text("Valou \n 158", textAlign: TextAlign.center, style: TextStyle(color: secondaryColor, fontSize: 20, fontWeight: FontWeight.bold),),
               thirdPosition: Text("Totouffe \n 133",textAlign: TextAlign.center, style: TextStyle(color: secondaryColor, fontSize: 20, fontWeight: FontWeight.bold),),
               color: secondaryColor,
               rankingTextColor: Colors.white,
               rankingFontSize: 30,
               hideRanking: false,
               showRankingNumberInsteadOfText: true,
               height: 250,
               width: 100,
               horizontalSpacing: 3,
             ),

            
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: players.length,
                      itemBuilder: (BuildContext context, index) {
                        print(players[index]);
                        final player = players[index];
                        return ListTile(
                          leading: Text((index + 4).toString(), style: const TextStyle(fontSize: 20)),
                          title: Text(player[0]),
                          trailing: Text(player[1].toString(), style: const TextStyle(fontSize: 20)),
                        );
                      },
                    ),
                  ),
                ),
                
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                          leading: Text(104.toString(), style: const TextStyle(fontSize: 20)),
                          title: Text('Dodo'),
                          trailing: Text(15.toString(), style: const TextStyle(fontSize: 20)),
                        )
                  ),
                ),

                ],

              ),
            )
        ],
      ),
    bottomNavigationBar: BottomNavigationBarPage(),

    );
  }
}