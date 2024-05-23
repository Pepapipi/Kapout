import 'package:flutter/material.dart';
import 'package:kapout/pages/category/list_quizzes.dart';
import 'package:kapout/pages/quiz/quiz_preview.dart';


class SelectCategory extends StatelessWidget {

  final String idCategory;
  final String name;
  final String image;
  const SelectCategory({required this.idCategory, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(
      fontSize: 25, // Taille de police souhaitée
      fontWeight: FontWeight.bold, // Police en gras
      color: Colors.white, // Couleur du texte en blanc
    );
    return GestureDetector(
      onTap: () {
        // Rediriger vers la page de quiz
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ListQuizzes(idCategory: idCategory)));
      },
      child: Container(
        width: 60,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2), // Contour noir
          borderRadius: BorderRadius.circular(10), // Bords arrondis
          image: DecorationImage(
              image: NetworkImage(image), // Image de fond
            fit: BoxFit.cover, // Ajustez l'image pour couvrir tout le conteneur
          ),
        ),
        margin: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft, // Texte en bas à gauche
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(name, style: textStyle),
              ),
            ),
          ],
        ),
      ),
    );

  }

}