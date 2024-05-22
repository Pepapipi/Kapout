import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kapout/components/form_container_widget.dart';
import 'package:kapout/components/toast.dart';
import 'package:kapout/constants.dart';
import 'package:kapout/pages/authentification/register.dart';
import 'package:kapout/pages/home/home.dart';
import 'package:kapout/services/firebase_auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isSigningIn = false;

    @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                const Image(
                  image: AssetImage('assets/flag_512x512.png'),
                  width: 250,
                  height: 250,
                ),
                const Text(
                  "Se connecter",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "Email",
                  isPasswordField: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Mot de passe",
                  isPasswordField: true,
                ),
            
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    _signIn();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: isSigningIn
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Se connecter",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Pas de compte ?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()),
                              (route) => false);
                        },
                        child: const Text(
                          "S'inscrire",
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.bold),
                        ))
                  ],
                )
            ]),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      isSigningIn = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      isSigningIn = false;
    });
    if (user != null) {
      showToast(message: "User is successfully connected");
        Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (BuildContext context) => const HomePage(),
  ));
    } else {
      showToast(message: "Some error happend");
    }
  }
}
