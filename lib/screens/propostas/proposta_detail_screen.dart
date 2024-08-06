import 'dart:convert';

import 'package:flutter/material.dart';
import '../../models/proposta.dart';
import '../../services/api_service.dart';
import 'package:http/http.dart' as http;

class PropostaDetailScreen extends StatefulWidget {
  final int propostaId;

  const PropostaDetailScreen({super.key, required this.propostaId});

  @override
  _PropostaDetailScreenState createState() => _PropostaDetailScreenState();
}

class _PropostaDetailScreenState extends State<PropostaDetailScreen> {
  late Future<Proposta> futureProposta;

  @override
  void initState() {
    super.initState();
    futureProposta = ApiService().fetchPropostaById(widget.propostaId);
  }

  Future<List<String>> fetchAutoresDetails(String? uriAutores) async {
    List<String> autoresDetails = [];
    if (uriAutores != null) {
      try {
        final response = await http.get(Uri.parse(uriAutores));
        if (response.statusCode == 200) {
          final List<dynamic> autores = json.decode(response.body)['dados'];
          for (var autor in autores) {
            autoresDetails.add(autor['nome']);
          }
        }
      } catch (error) {
        print('Erro ao buscar detalhes dos autores: $error');
      }
    }
    return autoresDetails;
  }

  String formatDate(String? dateString) {
    // Extrai o dia, mês e ano da string da data
    List<String>? parts = dateString?.split('T')[0].split('-');
    // Formata a data para o formato dd/mm/yyyy
    return '${parts?[2]}/${parts?[1]}/${parts?[0]}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Proposta'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<Proposta>(
        future: futureProposta,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os dados: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Nenhum dado encontrado.'));
          } else {
            Proposta proposta = snapshot.data!;
            return FutureBuilder<List<String>>(
              future: fetchAutoresDetails(proposta.uriAutores),
              builder: (context, autoresSnapshot) {
                if (autoresSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (autoresSnapshot.hasError) {
                  return Center(child: Text('Erro ao carregar os autores: ${autoresSnapshot.error}'));
                } else if (!autoresSnapshot.hasData || autoresSnapshot.data!.isEmpty) {
                  return const Text('Nenhum autor encontrado.');
                } else {
                  List<String> autores = autoresSnapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Autores: ',
                              style: TextStyle(fontSize: 14),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: autores.map((autor) => Text(autor)).toList(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('Data de Apresentação: ${formatDate(proposta.dataApresentacao)}'),
                        const SizedBox(height: 8),
                        Text('Ementa: ${proposta.ementa}'),
                        const SizedBox(height: 8),
                        Text('Situação: ${proposta.statusProposta}'),
                      ],
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
