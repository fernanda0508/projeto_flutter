import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importe o pacote intl
import '../../models/partido.dart';
import '../../services/api_service.dart';

class PartidoDetailScreen extends StatelessWidget {
  final int partidoId;

  const PartidoDetailScreen({super.key, required this.partidoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Partido'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<Partido>(
        future: ApiService().fetchPartidoById(partidoId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar os dados: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Nenhum dado encontrado.'));
          } else {
            Partido partido = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          partido.urlLogo != null && partido.urlLogo!.isNotEmpty
                              ? Image.network(
                                  partido.urlLogo!,
                                  height: 60,
                                  width: 60,
                                  errorBuilder: (context, error, stackTrace) {
                                    return _buildLogoPlaceholder(partido.sigla);
                                  },
                                )
                              : _buildLogoPlaceholder(partido.sigla),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              partido.nome,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoCard(context, partido),
                  const SizedBox(height: 20),
                  if (partido.status != null)
                    _buildStatusCard(context, partido.status!),
                  const SizedBox(height: 20),
                  _buildLeaderCard(context, partido.status?.lider),
                  const SizedBox(height: 20),
                  _buildLinks(partido),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildLogoPlaceholder(String sigla) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[300], // Cor de fundo do placeholder
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          sigla,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black54, // Cor do texto
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, Partido partido) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.info, 'Sigla:', partido.sigla),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.badge, 'ID:', partido.id.toString()),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.text_snippet, 'Nome:', partido.nome),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, StatusPartido status) {
    final DateTime dateTime = DateTime.parse(status.data);
    final String formattedDate =
        DateFormat('dd/MM/yyyy HH:mm').format(dateTime);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.check_circle, 'Situação:', status.situacao),
            const SizedBox(height: 10),
            _buildInfoRow(
                Icons.group, 'Total de Membros:', status.totalMembros),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.people, 'Total de Posse:', status.totalPosse),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.date_range, 'Data Status:', formattedDate),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderCard(BuildContext context, LiderPartido? lider) {
    if (lider == null) return Container();

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Líder do Partido',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                lider.urlFoto.isNotEmpty
                    ? Image.network(
                        lider.urlFoto,
                        height: 80,
                        width: 80,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey,
                          );
                        },
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey,
                      ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lider.nome,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'UF: ${lider.uf}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinks(Partido partido) {
    List<Widget> links = [];

    if (partido.urlWebSite != null) {
      links.add(_buildLinkRow(Icons.web, 'Website', partido.urlWebSite!));
    }
    if (partido.urlFacebook != null) {
      links
          .add(_buildLinkRow(Icons.facebook, 'Facebook', partido.urlFacebook!));
    }

    return Column(children: links);
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.deepPurple),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildLinkRow(IconData icon, String title, String url) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.deepPurple),
        const SizedBox(width: 8),
        Text(
          '$title:',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Implementar ação de abertura de URL
            },
            child: Text(
              url,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
