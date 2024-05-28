import 'package:flutter/material.dart';

class WidgetButtonAddFriend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 210,
      child: ElevatedButton(
          onPressed: () {
            
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8B2CF5),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('AJOUTER UN AMI',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              Icon(Icons.person_add, color: Colors.white),
            ],
          )),
    );
  }
}