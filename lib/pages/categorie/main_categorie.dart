import 'package:flutter/material.dart';

class CategoriePage extends StatefulWidget {
  @override
  _CategoriePageState createState() => _CategoriePageState();
}

class _CategoriePageState extends State<CategoriePage> {
  // Liste des éléments pour la recherche
  List<String> items = [
    'Dysney',
    '90s',
    '2000',
    'Rock',
    'Jazz',
  ];
  List<String> filteredItems = []; // Liste filtrée

  // Chemin vers l'image
  final String imagePath = 'assets/flag_256x256.png';

  //---------------MAIN-----------
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Chercher',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40, // Taille de la police
            ),
          ),
          actions: <Widget>[
            Container(
              child: Image.asset(imagePath),
            ),
          ],
        ),
        body: Container(
          // Container pour la marge
          margin: EdgeInsets.symmetric(horizontal: 20), // Marge
          child: Column(
            children: [
              buildRecherche(), // Barre de recherche en haut
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Nombre de colonnes
                    crossAxisSpacing:
                        2, // Espacement horizontal entre les colonnes
                    mainAxisSpacing: 2, // Espacement vertical entre les lignes
                    childAspectRatio:
                        2.5 / 2, //Ratio entre hauteur/largeur des rectangles
                  ),
                  itemCount: filteredItems.length,
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
            filteredItems = items
                .where(
                    (item) => item.toLowerCase().contains(value.toLowerCase()))
                .toList();
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
        image: DecorationImage(
          image: AssetImage(
              'assets/categorie/' + items[index] + '.png'), // Image de fond
          fit: BoxFit.cover, // Ajustez l'image pour couvrir tout le conteneur
        ),
      ),
      margin: EdgeInsets.all(8),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft, // Texte en bas à gauche
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(items[index], style: textStyle),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(CategoriePage());
}
