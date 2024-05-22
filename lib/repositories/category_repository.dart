import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kapout/models/category_model.dart';

class CategoryRepository {

  static CategoryRepository get instance => CategoryRepository();
  final _db = FirebaseFirestore.instance;
  
  Future<List<CategoryModel>> allCategories() async {
    final categories = await _db.collection('Category').get();
    return categories.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
  }

  
  Future<CategoryModel> getCategory(String id) async {
  final category = await _db.collection('Category').doc(id).get();
  return CategoryModel.fromSnapshot(category);
  }

}