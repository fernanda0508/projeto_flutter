// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/deputados/deputado_detail_screen.dart';
import '../../services/api_service.dart'; // Caminho para o serviço que faz chamadas de API
import '../../models/deputado.dart'; // Caminho para o modelo de dados Deputado

// Define uma StatefulWidget, DeputadosScreen, que é a tela onde os deputados serão listados.
class DeputadosScreen extends StatefulWidget {
  const DeputadosScreen({super.key});

  @override
  State<DeputadosScreen> createState() => _DeputadosScreenState();
}

// Estado associado ao DeputadosScreen, onde a lógica da interface e dados são gerenciados.
class _DeputadosScreenState extends State<DeputadosScreen> {
  // Declaração de uma variável para armazenar futuramente uma lista de Deputado.
  late Future<List<Deputado>> futureDeputados;

  @override
  void initState() {
    super.initState();
    // Inicializa a variável futureDeputados com o retorno da função fetchDeputados do ApiService.
    futureDeputados = ApiService().fetchDeputados();
  }

  @override
  Widget build(BuildContext context) {
    // Cria um Scaffold, que fornece a estrutura visual básica para a tela.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deputados'), // Título da AppBar.
      ),
      // Usa um FutureBuilder para construir a interface baseada no estado da Future futureDeputados.
      body: FutureBuilder<List<Deputado>>(
        future: futureDeputados,
        builder: (context, snapshot) {
          // Verifica o estado da conexão da Future.
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Mostra um indicador de carregamento enquanto os dados não são recebidos.
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Caso haja um erro na obtenção dos dados, mostra uma mensagem de erro.
            return Center(
                child: Text('Erro ao carregar os dados: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Caso não haja dados, mostra uma mensagem indicando que nenhum deputado foi encontrado.
            return const Center(child: Text('Nenhum deputado encontrado.'));
          } else {
            // Se os dados foram recebidos com sucesso, constrói uma lista de Cards para cada deputado.
            return ListView.builder(
              itemCount:
                  snapshot.data!.length, // Número de deputados recebidos.
              itemBuilder: (context, index) {
                Deputado dep =
                    snapshot.data![index]; // Deputado atual na lista.
                // InkWell é um widget material que responde ao toque com um efeito de "splash".
                return InkWell(
                  onTap: () {
                    // Evento que é chamado quando o InkWell é tocado.
                    Navigator.push(
                      // Navigator é o widget que gerencia a pilha de rotas (telas).
                      context, // Contexto do widget atual, usado para encontrar o Navigator.
                      MaterialPageRoute(
                        // MaterialPageRoute é uma rota que usa transições de tela do material design.
                        builder:
                            (context) => // Builder é uma função que constrói o widget para a nova rota.
                                DeputadoDetailScreen(
                                    deputado:
                                        dep), // Cria a tela de detalhes para o deputado selecionado.
                      ),
                    );
                  },
                  child: Card(
                    elevation:
                        5, // Elevação do Card para dar um efeito visual de profundidade.
                    child: Padding(
                      padding:
                          const EdgeInsets.all(8.0), // Padding interno do Card.
                      child: Row(
                        // Organiza conteúdo do Card em linha.
                        children: <Widget>[
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(dep.urlFoto),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left:
                                      16.0), // Espaço entre a imagem e o texto.
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    dep.nome,
                                    style: TextStyle(
                                      fontSize: 18,
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
