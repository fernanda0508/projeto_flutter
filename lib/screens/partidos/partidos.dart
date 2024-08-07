import 'package:flutter/material.dart';
import '../../services/api_service.dart'; // Caminho para o serviço que faz chamadas de API
import '../../models/partido.dart'; // Caminho para o modelo de dados Partido
import 'partido_detail_screen.dart'; // Tela de detalhes do partido

class PartidosScreen extends StatefulWidget {
  const PartidosScreen({super.key});

  @override
  State<PartidosScreen> createState() => _PartidosScreenState();
}

class _PartidosScreenState extends State<PartidosScreen> {
  late Future<List<Partido>> futurePartidos;

  @override
  void initState() {
    super.initState();
    futurePartidos = ApiService().fetchPartidos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partidos'),
      ),
      body: FutureBuilder<List<Partido>>(
        future: futurePartidos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar os dados: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum partido encontrado.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Partido partido = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    // Navega para a tela de detalhes do partido ao clicar em um item
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PartidoDetailScreen(partidoId: partido.id),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          partido.urlLogo != null && partido.urlLogo!.isNotEmpty
                              ? Image.network(
                                  partido.urlLogo!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return _buildLogoPlaceholder(partido.sigla);
                                  },
                                )
                              : _buildLogoPlaceholder(partido.sigla),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    partido.nome,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text('Sigla: ${partido.sigla}'),
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

  // Função para gerar uma cor a partir da sigla
  Color _getColorForSigla(String sigla) {
    final hash = sigla.hashCode;
    final red = (hash & 0xFF0000) >> 16;
    final green = (hash & 0x00FF00) >> 8;
    final blue = (hash & 0x0000FF);

    // Mistura a cor gerada com branco para obter tons pastéis
    return Color.fromARGB(255, red, green, blue).withOpacity(0.7);
  }

  // Função que constrói o placeholder para quando não há imagem
  Widget _buildLogoPlaceholder(String sigla) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[300], // Cor de fundo do placeholder
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          sigla,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: _getColorForSigla(sigla), // Cor do texto
          ),
        ),
      ),
    );
  }
}
