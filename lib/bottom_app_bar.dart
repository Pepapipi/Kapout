import 'package:flutter/material.dart';
import 'package:kapout/pages/authentification/login.dart';
import 'package:kapout/pages/category/ListQuizzCategory.dart';
import 'package:kapout/pages/category/main_category.dart';
import 'package:kapout/pages/home/home.dart';
import 'package:kapout/services/firebase_auth_service.dart';

class BottomNavigationBarPage extends StatelessWidget {
  const BottomNavigationBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: BottomAppBar(
        surfaceTintColor: Colors.white,
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const HomePage(),
                  ));
                },
                child: Image.asset('assets/navbar/music_notes.png',
                    width: 40, height: 40)),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>  const MainCategory(),
                  ));
                },
                child: Image.asset('assets/navbar/shield_violet.png',
                    width: 40, height: 40)),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const HomePage(),
                  ));
                },
                child: Image.asset('assets/navbar/plus.png',
                    width: 40, height: 40)),
      
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>  const ListQuizzCategoriePage(),
                  ));
                },
                child: Image.asset('assets/navbar/man.png',
                    width: 40, height: 40)),
      
            GestureDetector(
                onTap: () {
                  final FirebaseAuthService _auth = FirebaseAuthService();

                  _auth.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const Login(),
                  ));
                },
                child: Image.asset('assets/navbar/bell.png',
                    width: 40, height: 40)),
          ],
        ),
      ),
    );
  }
}
