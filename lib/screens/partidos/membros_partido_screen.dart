import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/membro_partido.dart'; // Importar a nova model
import '../deputados/deputado_detail_screen.dart';

class MembrosPartidoScreen extends StatelessWidget {
  final int partidoId;
  final String partidoNome;

  const MembrosPartidoScreen(
      {super.key, required this.partidoId, required this.partidoNome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Membros de $partidoNome'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<MembroPartido>>(
        future: ApiService().fetchMembrosPartido(partidoId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar os dados: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum membro encontrado.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                MembroPartido membro = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DeputadoDetailScreen(deputadoId: membro.id),
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
                              image: DecorationImage(
                                image: NetworkImage(membro.urlFoto.isNotEmpty
                                    ? membro.urlFoto
                                    : 'https://via.placeholder.com/80'),
                                fit: BoxFit.cover,
                                onError: (error, stackTrace) => Image.asset(
                                  'assets/images/placeholder.png', // Imagem de placeholder local
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    membro.nome,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                  ),
                                  Text(
                                    'Partido: ${membro.siglaPartido}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    'UF: ${membro.siglaUf}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
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
