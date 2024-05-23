import 'package:flutter/material.dart';

class WidgetTop4Top10 extends StatelessWidget {
  final List<List<dynamic>> bestScores;
  final List<dynamic> positionPlayer;

  const WidgetTop4Top10(
      {Key? key, required this.bestScores, required this.positionPlayer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: bestScores.length > 3 ? bestScores.length - 3 : 0,
                itemBuilder: (BuildContext context, index) {
                  List<dynamic> player = bestScores.length > index + 3
                      ? bestScores[index + 3]
                      : ["VIDE", "VIDE"];
                  return ListTile(
                    leading: Text((index + 4).toString(),
                        style: const TextStyle(fontSize: 20)),
                    title: Text(player[0]),
                    trailing: Text(player[1].toString(),
                        style: const TextStyle(fontSize: 20)),
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
                color: Colors.white),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Text(positionPlayer[0].toString(),
                      style: const TextStyle(fontSize: 20)),
                  title: Text(positionPlayer[1].toString()),
                  trailing: Text(positionPlayer[2].toString(),
                      style: const TextStyle(fontSize: 20)),
                )),
          ),
        ],
      ),
    );
  }
}
