import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(), // Tela de login como inicial
    );
  }
}
