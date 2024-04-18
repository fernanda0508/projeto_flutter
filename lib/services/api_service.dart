import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/deputado.dart'; // Ajuste o caminho conforme necessário

class ApiService {
  static const String baseUrl =
      'https://dadosabertos.camara.leg.br/api/v2/deputados';

  Future<List<Deputado>> fetchDeputados() async {
    final response =
        await http.get(Uri.parse('$baseUrl?ordem=ASC&ordenarPor=nome'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['dados'];
      return body.map((dynamic item) => Deputado.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load deputados');
    }
  }

  // Aqui você pode adicionar mais métodos para diferentes endpoints
}
