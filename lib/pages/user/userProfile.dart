import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kapout/bottom_app_bar.dart';
import 'package:kapout/models/user_model.dart';
import 'package:kapout/repositories/user_repository.dart';

class UserProfile extends StatefulWidget {
  final Future<UserModel> user;

  const UserProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  late UserProfile _userProfile;
  late Future<UserProfile> userFuture;
  late UserProfile? userProfile;

  @override
  void initState() {
    super.initState();
    widget.user.then((userProfile) {
      setState(() {
        //_userProfile = userProfile;
        //getUser();
      });
    }).catchError((error) {
      print("Error fetching user: $error");
    });
  }

  // void getUser() async {
  //    userFuture = UserRepository().instance.getUser(FirebaseAuth.instance.currentUser!.uid);
  //    userFuture.then((value) => user = value).catchError((error) {
  //      user = null;
  //      print("Error fetching user: $error");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings_rounded,
              size: 30,
            ),
            onPressed: () {
              // Add your share functionality here
            },
          ),
        ],
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/navbar/man.png'),
              width: 169,
              height: 169,
            ),
            const Text('Pseudo du user',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            Text('Membre depuis telle date',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600])),
          ],
        ),

        //////////////////

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 210,
              child: ElevatedButton(
                  onPressed: () {
                    //Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //builder: (BuildContext context) => Quiz(quiz: widget.quiz, userQuiz: userQuiz),
                    //));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_forward, color: Color(0xFF8B2CF5)),
                      Text('AJOUTER DES AMIS',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFF8B2CF5))),
                    ],
                  )),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              child: Icon(Icons.share),
              style: ElevatedButton.styleFrom(
                iconColor: Colors.purple,
              ),
            ),

////// STATISTIQUES titre

            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 22.0),
                  child: Text('Mes succès',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
              ],
            ),

////// 3 CASES

            const SizedBox(height: 10),
            FutureBuilder(
              future: userFuture,
              builder: (context, snapshot) {
                UserProfile _userProfile = snapshot.data!;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    statCard(
                      'Quizz terminés',
                      "QUIZZTOTAL",//"${_userProfile.quizzTotal}'",
                      const AssetImage('assets/chrono_512x512.png'),
                    ),
                    const SizedBox(width: 20),
                    statCard(
                      'XP gagnés',
                      "XPTOTAL",//"${_userProfile.xpTotal}'",
                      const AssetImage('assets/chrono_512x512.png'),
                    ),
                    const SizedBox(width: 20),
                    statCard(
                      'Temps total',
                      "TIMETOTAL",//"${_userProfile.timeTotal}'",
                      const AssetImage('assets/chrono_512x512.png'),
                    ),
                  ],
                );
              },
            ),

////// SHARE

            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.ios_share_rounded,
                          color: Color(0xFF8B2CF5), size: 30.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        //
      ]),
      bottomNavigationBar: BottomNavigationBarPage(),
    );
  }
}

Widget statCard(String title, String value, AssetImage image,
    [BuildContext? context, String? idQuiz, UserProfile? user]) {
  return GestureDetector(
    onTap: () {
      // Add your stat card functionality here
    },
    child: Container(
      width: 100,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFABABAB)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image(image: image, width: 50, height: 50),
          const SizedBox(height: 10),
          Text(value,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    ),
  );
}
