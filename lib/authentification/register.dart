import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Text("BIENVENUE SUR KAPOUT"),
        const Text("S'inscrire"),
        Padding(
          padding: const EdgeInsets.all(4),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Créer votre pseudo',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Insérer votre email',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Insérer un mot de passe',
            ),
            obscureText: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Confirmer le mot de passe',
            ),
            obscureText: true,

          ),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            minimumSize: MaterialStateProperty.all(Size.fromRadius(10))
          ),
          onPressed: () {},
          child: const Text('S\'inscrire'),
        )
      ]),
    );
  }
}
