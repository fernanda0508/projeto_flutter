import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/deputado.dart';
import '../models/deputadoGet.dart';

import '../models/partido.dart';

class ApiService {
  static const String baseUrlDeputados =
      'https://dadosabertos.camara.leg.br/api/v2/deputados';
  static const String baseUrlPartidos =
      'https://dadosabertos.camara.leg.br/api/v2/partidos';

  Future<List<DeputadoGet>> fetchDeputados() async {
    final response = await http
        .get(Uri.parse('$baseUrlDeputados?ordem=ASC&ordenarPor=nome'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['dados'];
      return body.map((dynamic item) => DeputadoGet.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load deputados');
    }
  }

  Future<List<Partido>> fetchPartidos() async {
    final response = await http
        .get(Uri.parse('$baseUrlPartidos?ordem=ASC&ordenarPor=sigla'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['dados'] != null) {
        List<dynamic> body = jsonData['dados'];
        return body.map((dynamic item) => Partido.fromJson(item)).toList();
      } else {
        throw Exception('Dados ausentes na resposta');
      }
    } else {
      throw Exception('Failed to load partidos');
    }
  }

  Future<Deputado> fetchDeputadoById(int id) async {
    final response = await http.get(Uri.parse('$baseUrlDeputados/$id'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['dados'] != null) {
        Map<String, dynamic> body = jsonData['dados'];
        return Deputado.fromJson(body); // Return the correct model
      } else {
        throw Exception('Dados ausentes na resposta');
      }
    } else {
      throw Exception('Failed to load deputado with id: $id');
    }
  }

  Future<Partido> fetchPartidoById(int id) async {
    final response = await http.get(Uri.parse('$baseUrlPartidos/$id'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['dados'] != null) {
        Map<String, dynamic> body = jsonData['dados'];
        return Partido.fromJson(body);
      } else {
        throw Exception('Dados ausentes na resposta');
      }
    } else {
      throw Exception('Failed to load partido with id: $id');
    }
  }
}
