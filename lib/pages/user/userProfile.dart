import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kapout/bottom_app_bar.dart';
import 'package:kapout/models/user_model.dart';
import 'package:kapout/pages/user/widgets/widget_button_add_friend.dart';
import 'package:kapout/pages/user/widgets/widget_my_success.dart';
import 'package:kapout/pages/user/widgets/widget_profile.dart';
import 'package:kapout/pages/user/widgets/widget_share.dart';
import 'package:kapout/repositories/user_repository.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  late Future<UserModel> userFuture = UserRepository.instance.getUser(FirebaseAuth.instance.currentUser!.uid);
     
  @override
  void initState() {
    super.initState();
    Future<UserModel> userFuture = UserRepository.instance.getUser(FirebaseAuth.instance.currentUser!.uid);
  }

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
      body: FutureBuilder(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel _userProfile = snapshot.data as UserModel;
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                  const SizedBox(height: 20),
                  WidgetProfile(pseudo: _userProfile.name, createdAt: _userProfile.createdAt,),
                  const SizedBox(height: 20),
                  WidgetButtonAddFriend(),
                  const SizedBox(height: 20),
                  WidgetMySuccess(userProfile: _userProfile),
                  const SizedBox(height: 20),
                  WidgetShare(),
                  ],
                );              
              }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: const BottomNavigationBarPage(),
    );
  }
}


