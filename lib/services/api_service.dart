import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/deputado.dart';
import '../models/deputadoGet.dart';
import '../models/membro_partido.dart';
import '../models/partido.dart';
import '../models/despesa.dart';

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

  Future<List<MembroPartido>> fetchMembrosPartido(int partidoId) async {
    final response =
        await http.get(Uri.parse('$baseUrlPartidos/$partidoId/membros'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['dados'];
      return body.map((dynamic item) => MembroPartido.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load membros do partido');
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

  Future<List<Despesa>> fetchDespesasDeputado(int deputadoId) async {
    final response = await http.get(Uri.parse(
        '$baseUrlDeputados/$deputadoId/despesas?ordem=ASC&ordenarPor=ano'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['dados'];
      return body.map((dynamic item) => Despesa.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load despesas');
    }
  }

  Future<List<DeputadoGet>> fetchDeputadosByName(String name) async {
    List<DeputadoGet> deputados = await fetchDeputados();
    return deputados
        .where((deputado) =>
            deputado.nome.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  Future<List<Partido>> fetchPartidoByName(String name) async {
    List<Partido> partidos = await fetchPartidos();
    return partidos
        .where((partido) =>
            partido.nome.toLowerCase().contains(name.toLowerCase()))
        .toList();
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
