import 'package:flutter/material.dart';
import 'package:kapout/pages/quiz/quiz_preview.dart';


class SelectQuiz extends StatelessWidget {

  final String idQuiz;
  final String name;
  final String image;
  final String bgColor;
  final String textColor;
  
  const SelectQuiz({required this.idQuiz, required this.name, required this.image, required this.bgColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(
      fontSize: 16, // Taille de police souhaitée
      fontWeight: FontWeight.bold, // Police en gras
      color: Colors.white, // Couleur du texte en blanc
    );
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => QuizPreview(idQuiz: idQuiz)));
      },
      child: Container(
        width: 10,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2), // Contour noir
          borderRadius: BorderRadius.circular(10), // Bords arrondis
          color: Colors.red, // Couleur de fond (remplacer si nécessaire)
        ),
        margin: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 100, // Largeur max de l'image
              height: 80, // Hauteur max de l'image
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                image: DecorationImage(
                  image: NetworkImage(image), //récupération des images en fonction du nom du quizz
                  fit: BoxFit.cover, // Ajustez l'image pour couvrir tout
                  // le conteneur
                ),
              ),
            ),
            Expanded(
              //Mettre le contenus texte sur le côté droit des rectangles
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft, // Texte en haut gauche
                  child: Text(name, style: textStyle), //récupération
                  //des nom de quizz
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}