import 'package:flutter/material.dart';

class ListQuizzCategoriePage extends StatefulWidget {
  @override
  _ListQuizzCategoriePageState createState() => _ListQuizzCategoriePageState();
}

class _ListQuizzCategoriePageState extends State<ListQuizzCategoriePage> {
  // Liste test des noms de quizz
  List<String> itemsquizz = [
    'Disney',
    'Le roi lion',
    'La reine des neiges',
    'Blanche Neige',
  ];

  final String nomCategorie = 'Disney'; //Cela représente le nom de la catégorie
  //sur laquel l'utilisateur a cliqué

  // Chemin vers le logo utilisé en haut à droite de la page
  final String imageLogoPath = 'assets/flag_256x256.png';

  //---------------MAIN-----------
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            nomCategorie,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40, // Taille de la police
            ),
          ),
          actions: <Widget>[
            Image.asset(imageLogoPath), //logo en haut à droite
          ],
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
                        6 / 2, //Ratio entre hauteur/largeur des rectangles
                  ),
                  itemCount: itemsquizz.length,
                  itemBuilder: (context, index) {
                    return buildRectangle(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
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
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
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
  Widget buildRectangle(int index) {
    const TextStyle textStyle = TextStyle(
      fontSize: 25, // Taille de police souhaitée
      fontWeight: FontWeight.bold, // Police en gras
      color: Colors.white, // Couleur du texte en blanc
    );
    return Container(
      width: 60,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2), // Contour noir
        borderRadius: BorderRadius.circular(10), // Bords arrondis
        color: Colors.grey, // Couleur de fond (remplacer si nécessaire)
      ),
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 120, // Largeur max de l'image
            height: 120, // Hauteur max de l'image
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              image: DecorationImage(
                image: AssetImage('assets/quizzImage/' +
                    itemsquizz[index] +
                    '.png'), //récupération des images en fonction du nom du quizz
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
                child: Text(itemsquizz[index], style: textStyle), //récupération
                //des nom de quizz
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(ListQuizzCategoriePage());
}
