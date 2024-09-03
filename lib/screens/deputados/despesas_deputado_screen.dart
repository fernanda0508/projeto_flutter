import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import para formatação de data
import '../../models/despesa.dart';
import '../../services/api_service.dart';

class DespesasDeputadoScreen extends StatelessWidget {
  final int deputadoId;

  const DespesasDeputadoScreen({super.key, required this.deputadoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Parlamentares'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<Despesa>>(
        future: ApiService().fetchDespesasDeputado(deputadoId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar os dados: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma despesa encontrada.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Despesa despesa = snapshot.data![index];

                // Formatação da data para o formato brasileiro
                final String dataFormatada = DateFormat('dd/MM/yyyy')
                    .format(DateTime.parse(despesa.dataDocumento));

                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(despesa.tipoDespesa),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Valor: R\$ ${despesa.valorLiquido.toStringAsFixed(2)}',
                        ),
                        Text('Data: $dataFormatada'), // Data formatada
                        Text('Fornecedor: ${despesa.nomeFornecedor}'),
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
