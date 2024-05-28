import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WidgetProfile extends StatelessWidget {

  final String pseudo;
  final Timestamp createdAt;

  WidgetProfile({super.key, required this.pseudo, required this.createdAt});
  @override
  Widget build(BuildContext context) {
    return                 Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/navbar/man.png'),
                      width: 169,
                      height: 169,
                    ),
                    Text(pseudo,
                        style: const TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold)),
                    Text('Membre depuis ${DateTime.now().difference(createdAt.toDate()).inDays} jours',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600])),
                  ],
                );
  }
}