import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {

  static FirebaseStorageService get instance => FirebaseStorageService();


  Future<String> getAsset(String path) async {
      return await FirebaseStorage.instance.ref(path).getDownloadURL();
  }
  
}