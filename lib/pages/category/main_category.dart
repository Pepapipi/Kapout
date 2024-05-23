import 'package:flutter/material.dart';
import 'package:kapout/bottom_app_bar.dart';
import 'package:kapout/models/category_model.dart';
import 'package:kapout/pages/category/widget_select_category.dart';
import 'package:kapout/repositories/category_repository.dart';
import 'package:kapout/services/firebase_storage_service.dart';

class MainCategory extends StatefulWidget {
  
  const MainCategory({Key? key}) : super(key: key);
  @override
  State<MainCategory> createState() => _MainCategoryState();
}

class _MainCategoryState extends State<MainCategory> {
  // Liste des éléments pour la recherche
  List<CategoryModel> categories = [];
  List<String> images = [];

  // Chemin vers l'image
  final String imagePath = 'assets/flag_256x256.png';

  //---------------INITIALISATION-----------
  @override
  void initState() {
    super.initState();
    List<String> imagesTamp = [];
    CategoryRepository.instance.allCategories().then((value) async {
      for (var i = 0; i < value.length; i++) {
        imagesTamp.add(await FirebaseStorageService.instance.getAsset(value[i].image));
      }
      //Tableau des images
      setState(() {
        categories = value;
        images = imagesTamp;
      });
    }).catchError((error) {
      // Gérer l'erreur en conséquence, par exemple, afficher un message d'erreur
    });
  }
  //---------------MAIN-----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Chercher',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40, // Taille de la police
                  ),
                ),
                Image.asset(imagePath, width: 50, height: 50),
              ],
            ),
          ),
         
        ),
        body: Container(
          // Container pour la marge
          margin: const EdgeInsets.symmetric(horizontal: 20), // Marge
          child: Column(
            children: [
              buildRecherche(), // Barre de recherche en haut
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Nombre de colonnes
                    crossAxisSpacing: 2, // Espacement horizontal entre les colonnes
                    mainAxisSpacing: 2, // Espacement vertical entre les lignes
                    childAspectRatio: 2.5 / 2, //Ratio entre hauteur/largeur des rectangles
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return SelectCategory(name: categories[index].name, image: images[index],idCategory:  categories[index].id!);
                  },
                ),
              ),
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

        },
      ),
    );
  }
}


