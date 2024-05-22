import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel{
  String name;
  String image;
  List<String> quizzes; // En fait, je pense que le mieux est de mettre un String ici, et de faire un fetch des quizzes dans le constructeur
  CategoryModel({required this.name, required this.image, this.quizzes = const []});

  static CategoryModel fromMap(Map<String, dynamic> map,String id) {
    return CategoryModel(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      quizzes:map['quizzes'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'quizzes': quizzes,
    };
  }

    factory CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    return CategoryModel.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }
}