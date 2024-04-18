import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Deputado {
  final int id;
  final String nome;
  final String siglaPartido;
  final String siglaUf;
  final String urlFoto;
  final String email;

  Deputado({
    required this.id,
    required this.nome,
    required this.siglaPartido,
    required this.siglaUf,
    required this.urlFoto,
    required this.email,
  });

  factory Deputado.fromJson(Map<String, dynamic> json) {
    return Deputado(
      id: json['id'],
      nome: json['nome'],
      siglaPartido: json['siglaPartido'],
      siglaUf: json['siglaUf'],
      urlFoto: json['urlFoto'],
      email: json['email'],
    );
  }
}

class DeputadosScreen extends StatefulWidget {
  const DeputadosScreen({super.key});

  @override
  _DeputadosScreenState createState() => _DeputadosScreenState();
}

class _DeputadosScreenState extends State<DeputadosScreen> {
  late Future<List<Deputado>> futureDeputados;

  @override
  void initState() {
    super.initState();
    futureDeputados = fetchDeputados();
  }

  Future<List<Deputado>> fetchDeputados() async {
    final response = await http.get(
      Uri.parse(
          'https://dadosabertos.camara.leg.br/api/v2/deputados?ordem=ASC&ordenarPor=nome'),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['dados'];
      List<Deputado> deputados =
          body.map((dynamic item) => Deputado.fromJson(item)).toList();
      return deputados;
    } else {
      throw Exception('Failed to load deputados');
    }
  }

// Continuação do código anterior
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deputados'),
      ),
      body: FutureBuilder<List<Deputado>>(
        future: futureDeputados,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar os dados: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum deputado encontrado.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Deputado dep = snapshot.data![index];
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(dep.urlFoto),
                    ),
                    title: Text(dep.nome),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Partido: ${dep.siglaPartido}'),
                        Text('UF: ${dep.siglaUf}'),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
