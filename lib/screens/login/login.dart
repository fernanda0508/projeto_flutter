import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Verifica se os campos têm pelo menos dois caracteres
                if (nameController.text.length >= 2 && passwordController.text.length >= 2) {
                  // Passa o nome do usuário para a HomeScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(userName: nameController.text),
                    ),
                  );
                } else {
                  // Exibe uma mensagem de erro se a validação falhar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Digite pelo menos 2 caracteres em cada campo.')),
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
