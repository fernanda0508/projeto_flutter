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
        title: const Text('Política Connect'),
        backgroundColor: Colors.deepPurple, // Cor do AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.start, // Alinhamento à esquerda
            children: <Widget>[
              const Text(
                'Bem-vindo ao Política Connect',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple, // Cor do texto
                ),
              ),
              const SizedBox(height: 8.0), // Espaço entre as linhas de texto
              const Text(
                'Faça seu login abaixo para continuar',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54, // Cor mais suave para o subtítulo
                ),
              ),
              const SizedBox(
                  height: 32.0), // Espaço maior entre o texto e o formulário
              const Text(
                'Aqui você encontra transparência e interação direta com seus representantes. Juntos, conectamos a política à sua realidade.',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle
                      .italic, // Estilo em itálico para destacar o bordão
                  color:
                      Colors.deepPurpleAccent, // Cor para diferenciar o texto
                ),
              ),
              const SizedBox(
                  height: 32.0), // Espaço maior entre o bordão e o formulário
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(), // Borda ao redor do campo
                  prefixIcon: Icon(Icons.person), // Ícone de pessoa
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock), // Ícone de cadeado
                ),
                obscureText: true,
              ),
              const SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Verifica se os campos têm pelo menos dois caracteres
                    if (nameController.text.length >= 2 &&
                        passwordController.text.length >= 2) {
                      // Passa o nome do usuário para a HomeScreen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomeScreen(userName: nameController.text),
                        ),
                      );
                    } else {
                      // Exibe uma mensagem de erro se a validação falhar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Digite pelo menos 2 caracteres em cada campo.')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // Cor de fundo do botão
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16), // Tamanho do botão
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold, // Deixar o texto em negrito
                      color: Colors.white, // Cor do texto
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
