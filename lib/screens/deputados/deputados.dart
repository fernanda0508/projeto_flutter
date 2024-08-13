import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/deputados/deputado_detail_screen.dart';
import 'package:flutter_application_1/screens/home.dart';
import '../../services/api_service.dart'; // Caminho para o serviço que faz chamadas de API
import '../../models/deputadoGet.dart'; // Caminho para o modelo de dados Deputado

class DeputadosScreen extends StatefulWidget {
  const DeputadosScreen({super.key, this.deputados, required this.userName});
  final List<DeputadoGet>? deputados;
  final String userName;

  @override
  State<DeputadosScreen> createState() => _DeputadosScreenState();
}

class _DeputadosScreenState extends State<DeputadosScreen> {
  late Future<List<DeputadoGet>> futureDeputados;

  @override
  void initState() {
    super.initState();
    if (widget.deputados != null) {
      futureDeputados = Future.value(widget.deputados);
    } else {
      futureDeputados = ApiService().fetchDeputados();
    }
  }

  buscarDeputado(String value, String nome) async {
    var deputadosBuscados = await ApiService().fetchDeputadosByName(value);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => HomeScreen(deputadosBuscados: deputadosBuscados, userName: nome,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8.0), // Margem para separar o campo de busca do título
              child: TextField(
                onSubmitted: (value) => buscarDeputado(value, widget.userName),
                decoration: InputDecoration(
                  hintText: "Buscar", // Texto de placeholder
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            const Text(
              'Deputados',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        toolbarHeight: 120, // Altura personalizada para acomodar o TextField e o título
      ),
      body: FutureBuilder<List<DeputadoGet>>(
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
                DeputadoGet dep = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DeputadoDetailScreen(deputadoId: dep.id),
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
                                image: NetworkImage(dep.urlFoto),
                                fit: BoxFit.cover,
                                onError: (error, stackTrace) {
                                  setState(() {});
                                },
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
                                    dep.nome,
                                    style: const TextStyle(
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

  // Função que constrói o placeholder para quando não há imagem
  Widget _buildFotoPlaceholder() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[300], // Cor de fundo do placeholder
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Icon(
          Icons.person,
          size: 40,
          color: Colors.grey[600], // Cor do ícone
        ),
      ),
    );
  }
}
