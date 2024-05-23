import 'package:flutter/material.dart';
import 'package:kapout/bottom_app_bar.dart';
import 'package:kapout/models/quiz_model.dart';
import 'package:kapout/pages/quiz/quiz_preview.dart';
import 'package:kapout/repositories/category_repository.dart';
import 'package:kapout/repositories/quiz_repository.dart';
import 'package:kapout/services/firebase_storage_service.dart';

class ListQuizzes extends StatefulWidget {

  final String idCategory;
  const ListQuizzes({required this.idCategory,super.key});

  @override
  _ListQuizzesState createState() => _ListQuizzesState();
}

class _ListQuizzesState extends State<ListQuizzes> {
  // Liste test des noms de quizz
  List<QuizModel> quizzes = [];
  List<String> images = [];
  String nameCategory= '';

  //sur laquel l'utilisateur a cliqué

  // Chemin vers le logo utilisé en haut à droite de la page
  final String imageLogoPath = 'assets/flag_256x256.png';

  @override
  void initState()  {
    super.initState();
    CategoryRepository.instance.getCategory(widget.idCategory).then((value) async {
        List<QuizModel> quizzesTamp = [];
        List<String> imagesTamp = [];

      for(String idQuiz in value.quizzes){
        QuizModel quiz = await QuizRepository.instance.getQuiz(idQuiz);
        await FirebaseStorageService.instance.getAsset(quiz.image!).then((value) {
          imagesTamp.add(value);
        }
        );
        quizzesTamp.add(await QuizRepository.instance.getQuiz(idQuiz));
      }

      setState(() {
        quizzes = quizzesTamp;
        images = imagesTamp;
        nameCategory = value.name;
      });
     
    } );
  }

  //---------------MAIN-----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nameCategory,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30, // Taille de la police
                  ),
                ),
                Image.asset(imageLogoPath,  width: 50, height: 50),
              ],
            ),
          ),

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
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // Nombre de colonnes
                    crossAxisSpacing:
                        2, // Espacement horizontal entre les colonnes
                    mainAxisSpacing: 2, // Espacement vertical entre les lignes
                    childAspectRatio:
                       8 / 2, //Ratio entre hauteur/largeur des rectangles
                  ),
                  itemCount: quizzes.length,
                  itemBuilder: (context, index) {
                    return buildRectangle(quizzes[index].id!, quizzes[index].name, images[index], quizzes[index].bgColor!, quizzes[index].textColor!);
                  },
                ),
              ),
            ],
          ),
        ),
bottomNavigationBar: const BottomNavigationBarPage(),      );
    
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

  //---------RECTANGLES--------------
  // Widget pour les rectangles
  Widget buildRectangle(String idQuiz, String name, String image, String bgColor, String textColor) {
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

