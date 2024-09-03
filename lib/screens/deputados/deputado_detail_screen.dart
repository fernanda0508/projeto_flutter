import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/deputado.dart';
import '../../services/api_service.dart';
import 'despesas_deputado_screen.dart'; // Importe a tela de despesas do deputado

class DeputadoDetailScreen extends StatelessWidget {
  final int deputadoId;

  const DeputadoDetailScreen({super.key, required this.deputadoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Deputado'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<Deputado>(
        future: ApiService().fetchDeputadoById(deputadoId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar os dados: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Nenhum dado encontrado.'));
          } else {
            Deputado deputado = snapshot.data!;
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
                          Image.network(
                            deputado.ultimoStatus?.urlFoto ??
                                'assets/images/placeholder.png',
                            height: 80,
                            width: 80,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey,
                                child: const Icon(Icons.person, size: 50),
                              );
                            },
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  deputado.ultimoStatus?.nomeEleitoral ??
                                      deputado.nomeCivil,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                  overflow: TextOverflow.visible,
                                  softWrap: true,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Partido: ${deputado.ultimoStatus?.siglaPartido ?? 'Não disponível'}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildPersonalInfoCard(deputado),
                  const SizedBox(height: 20),
                  _buildOfficeCard(deputado, deputado.ultimoStatus?.gabinete),
                  const SizedBox(height: 20),
                  _buildStatusCard(deputado),
                  const SizedBox(height: 20),
                  _buildDespesasButton(context), // Adiciona o botão de despesas
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildPersonalInfoCard(Deputado deputado) {
    final String birthDate = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(deputado.dataNascimento!));
    final String? deathDate = deputado.dataFalecimento != null
        ? DateFormat('dd/MM/yyyy')
            .format(DateTime.parse(deputado.dataFalecimento!))
        : null;

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
            _buildInfoRow(Icons.person, 'Nome Civil:', deputado.nomeCivil),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.cake, 'Nascimento:',
                '$birthDate ${deathDate != null ? '- $deathDate' : ''}'),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.location_city, 'Naturalidade:',
                '${deputado.municipioNascimento}, ${deputado.ufNascimento}'),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.school, 'Escolaridade:',
                deputado.escolaridade ?? 'Não disponível'),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.email, 'Email:',
                deputado.ultimoStatus?.email ?? 'Não disponível'),
          ],
        ),
      ),
    );
  }

  Widget _buildOfficeCard(Deputado deputado, Gabinete? gabinete) {
    if (gabinete == null) {
      return Container(); // Exibe um container vazio se gabinete for null
    }
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
            Text(
              'Gabinete do ${deputado.ultimoStatus?.nomeEleitoral ?? deputado.nomeCivil}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.apartment, 'Prédio:',
                gabinete.predio ?? 'Não disponível'),
            const SizedBox(height: 10),
            _buildInfoRow(
                Icons.meeting_room, 'Sala:', gabinete.sala ?? 'Não disponível'),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.phone, 'Telefone:',
                gabinete.telefone ?? 'Não disponível'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(Deputado deputado) {
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
            _buildInfoRow(Icons.check_circle, 'Situação:',
                deputado.ultimoStatus?.situacao ?? 'N/A'),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.group, 'Legislatura:',
                deputado.ultimoStatus?.idLegislatura.toString() ?? 'N/A'),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.location_pin, 'UF:',
                deputado.ultimoStatus?.siglaUf ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  Widget _buildDespesasButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DespesasDeputadoScreen(deputadoId: deputadoId),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple, // Cor de fundo do botão
      ),
      child: const Text(
        'Despesas (Cota Parlamentar)',
        style: TextStyle(
          color: Colors.white, // Cor do texto do botão
          fontWeight: FontWeight.bold, // Deixar o texto em negrito
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.deepPurple),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
