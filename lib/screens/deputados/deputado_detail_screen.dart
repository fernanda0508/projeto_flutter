// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../models/deputado.dart'; // Certifique-se de que o caminho está correto.

class DeputadoDetailScreen extends StatelessWidget {
  final Deputado deputado;

  const DeputadoDetailScreen({super.key, required this.deputado});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(deputado.nome),
      ),
      body: Center(
        // Usa o widget Center para centralizar o conteúdo
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // Usa o espaço mínimo necessário, centralizando verticalmente
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(deputado.urlFoto),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 20),
            Text(
              deputado.nome,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              textAlign: TextAlign.center, // Centraliza o texto
            ),
            Text(
              "${deputado.siglaPartido}/${deputado.siglaUf}",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20,
              ),
              textAlign: TextAlign.center, // Centraliza o texto
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Implementar funcionalidade
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text('Ver projetos'),
            ),
          ],
        ),
      ),
    );
  }
}
