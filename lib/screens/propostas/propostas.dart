import 'package:flutter/material.dart';

import '../../models/proposta.dart';
import '../../services/api_service.dart';
import 'proposta_detail_screen.dart'; // Importar a tela de detalhes da proposta

class PropostasScreen extends StatefulWidget {
  const PropostasScreen({Key? key}) : super(key: key);

  @override
  _PropostasScreenState createState() => _PropostasScreenState();
}

class _PropostasScreenState extends State<PropostasScreen> {
  late Future<List<Proposta>> futurePropostas;

  @override
  void initState() {
    super.initState();
    futurePropostas = ApiService().fetchPropostas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Propostas'),
        backgroundColor: Colors.blue, // Cor de fundo da AppBar
      ),
      body: FutureBuilder<List<Proposta>>(
        future: futurePropostas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os dados: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma proposta encontrada.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Proposta proposta = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    // Navegar para a tela de detalhes da proposta quando clicado
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PropostaDetailScreen(propostaId: proposta.id),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.blue, // Cor de fundo do container da imagem
                              // image: DecorationImage(
                              //   image: NetworkImage(proposta.urlImagem),
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    proposta.ementa,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text('Tipo: ${proposta.siglaTipo}'),
                                  Text('Número: ${proposta.numero}'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
