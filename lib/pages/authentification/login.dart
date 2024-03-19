import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              minimumSize:
                  MaterialStateProperty.all(const Size.fromRadius(10))),
          onPressed: () {},
          child: const Text('Se connecter'),
        )
      ]),
    );
  }
}
