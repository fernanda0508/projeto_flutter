import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/proposta.dart';

class DetalhesPropostaScreen extends StatelessWidget {
  final Proposta proposta;

  const DetalhesPropostaScreen({required this.proposta});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(proposta.ementa),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detalhes da Proposta',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text('Tipo: ${proposta.siglaTipo}, Número: ${proposta.numero}/${proposta.ano}'),
            // Adicione mais informações da proposta conforme necessário
          ],
        ),
      ),
    );
  }
}