import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String name;
  String mail;
  String icon;
  String idLeague;
  String idCumul;
  int quizzTotal;
  int xpTotal;
  int timeTotal;
  Timestamp createdAt;


  UserModel({
    required this.id,
    required this.name,
    required this.mail,
    required this.icon,
    required this.idLeague,
    required this.idCumul,
    required this.quizzTotal,
    required this.xpTotal,
    required this.timeTotal,
    required this.createdAt,
  }); 

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: map['name'],
      mail: map['mail'],
      icon: map['icon'],
      idLeague: map['idLeague'],
      idCumul: map['idCumul'],
      quizzTotal: map['quizzTotal'],
      xpTotal: map['xpTotal'],
      timeTotal: map['timeTotal'],
      createdAt: map['createdAt'],
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }
}
