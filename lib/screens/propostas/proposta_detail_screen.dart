import 'package:flutter/material.dart';

import '../../models/proposta.dart';

class PropostaDetailScreen extends StatelessWidget {
  final Proposta proposta;

  const PropostaDetailScreen({Key? key, required this.proposta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(proposta.ementa),
        backgroundColor: Colors.blue, // Cor de fundo da AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Autor: ${proposta.autor}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Data de Apresentação: ${proposta.dataApresentacao}'),
            SizedBox(height: 8),
            Text('Ementa: ${proposta.ementa}'),
            SizedBox(height: 8),
            Text('Situação: ${proposta.situacao}'),
            SizedBox(height: 8),
            Text('Autores: ${proposta.autores}'),
            // Adicione mais detalhes da proposta conforme necessário
          ],
        ),
      ),
    );
  }
}
