import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/deputado.dart';

// Define a classe ApiService que será responsável por toda comunicação com a API externa.
class ApiService {
  // Define uma constante para a URL base da API da Câmara dos Deputados.
  static const String baseUrl =
      'https://dadosabertos.camara.leg.br/api/v2/deputados';

  // Método assíncrono que busca os deputados e retorna uma lista de objetos Deputado.
  Future<List<Deputado>> fetchDeputados() async {
    // Faz uma requisição GET para a URL da API, com parâmetros para ordenação por nome em ordem ascendente.
    final response =
        await http.get(Uri.parse('$baseUrl?ordem=ASC&ordenarPor=nome'));

    // Verifica se a resposta da requisição foi bem-sucedida (código de status HTTP 200).
    if (response.statusCode == 200) {
      // Decodifica o corpo da resposta que está em formato JSON.
      List<dynamic> body = json.decode(response.body)['dados'];
      // Mapeia cada item do corpo decodificado para um objeto Deputado usando a factory Deputado.fromJson.
      return body.map((dynamic item) => Deputado.fromJson(item)).toList();
    } else {
      // Lança uma exceção se o status code não for 200, indicando falha no carregamento dos dados.
      throw Exception('Failed to load deputados');
    }
  }

  // Aqui você pode adicionar mais métodos para diferentes endpoints
}
