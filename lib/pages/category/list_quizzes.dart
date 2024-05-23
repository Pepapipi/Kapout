import 'package:flutter/material.dart';
import 'package:kapout/bottom_app_bar.dart';
import 'package:kapout/components/app_bar_quiz_categorie.dart';
import 'package:kapout/models/quiz_model.dart';
import 'package:kapout/pages/category/widget_expanded_quiz.dart';
import 'package:kapout/repositories/category_repository.dart';
import 'package:kapout/repositories/quiz_repository.dart';
import 'package:kapout/services/firebase_storage_service.dart';

class ListQuizzes extends StatefulWidget {
  final String idCategory;
  const ListQuizzes({required this.idCategory, super.key});

  @override
  _ListQuizzesState createState() => _ListQuizzesState();
}

class _ListQuizzesState extends State<ListQuizzes> {
  // Liste test des noms de quizz
  List<QuizModel> quizzes = [];
  List<String> images = [];
  String nameCategory = '';

  @override
  void initState() {
    super.initState();
    CategoryRepository.instance
        .getCategory(widget.idCategory)
        .then((value) async {
      List<QuizModel> quizzesTamp = [];
      List<String> imagesTamp = [];

      for (String idQuiz in value.quizzes) {
        QuizModel quiz = await QuizRepository.instance.getQuiz(idQuiz);
        await FirebaseStorageService.instance
            .getAsset(quiz.image!)
            .then((value) {
          imagesTamp.add(value);
        });
        quizzesTamp.add(await QuizRepository.instance.getQuiz(idQuiz));
      }

      setState(() {
        quizzes = quizzesTamp;
        images = imagesTamp;
        nameCategory = value.name;
      });
    });
  }

  //---------------MAIN-----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarQuizCategorie(name: nameCategory),
      ),
      body: Container(
        // Container pour la marge
        margin: const EdgeInsets.symmetric(horizontal: 20), // Marge entre les
        // éléments du haut et le body
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alignement du texte à gauche
          children: [
            buildRecherche(), // Barre de recherche en haut
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Tous les quizz disponibles',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ExpandedQuiz(quizzes: quizzes, images: images)
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarPage(),
    );
  }

  //----------------BARRE DE RECHERCHES---------------
  // Widget pour la barre de recherche
  Widget buildRecherche() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Rechercher...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: (value) {
          setState(() {
            //FILTRE DE RECHERCHE
          });
        },
      ),
    );
  }
}
