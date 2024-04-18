// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Ajuste o caminho conforme necessário
import '../models/deputado.dart'; // Ajuste o caminho conforme necessário

class DeputadosScreen extends StatefulWidget {
  const DeputadosScreen({Key? key}) : super(key: key);

  @override
  State<DeputadosScreen> createState() => _DeputadosScreenState();
}

class _DeputadosScreenState extends State<DeputadosScreen> {
  late Future<List<Deputado>> futureDeputados;

  @override
  void initState() {
    super.initState();
    futureDeputados = ApiService().fetchDeputados();
  }

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
                  child: Padding(
                    padding: const EdgeInsets.all(
                        8.0), // Ajuste para mais espaço dentro do Card
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 80, // Ajuste a largura conforme necessário
                          height:
                              80, // Ajuste a altura para que seja igual à largura, formando um quadrado
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(
                                8), // Para ter cantos arredondados
                            image: DecorationImage(
                              image: NetworkImage(dep.urlFoto),
                              fit: BoxFit
                                  .cover, // Isso irá cobrir todo o espaço do container mantendo a proporção da imagem
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0), // Espaço entre a imagem e o texto
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  dep.nome,
                                  style: TextStyle(
                                    fontSize: 18, // Tamanho do texto do nome
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text('Partido: ${dep.siglaPartido}'),
                                Text('UF: ${dep.siglaUf}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
