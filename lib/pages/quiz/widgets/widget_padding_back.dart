import 'package:flutter/material.dart';
import 'package:kapout/constants.dart';
import 'package:kapout/pages/category/main_category.dart';

class PaddingBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const MainCategory()));
          
        },
        child: Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
              child: Text(
            "Revenir au menu",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
