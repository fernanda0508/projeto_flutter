import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/deputado.dart';
import '../models/proposta.dart'; // Importe a classe Proposta aqui

class ApiService {
  static const String baseUrlDeputados =
      'https://dadosabertos.camara.leg.br/api/v2/deputados';
  static const String baseUrlPropostas =
      'https://dadosabertos.camara.leg.br/api/v2/proposicoes';

  Future<List<Deputado>> fetchDeputados() async {
    final response = await http.get(Uri.parse('$baseUrlDeputados?ordem=ASC&ordenarPor=nome'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['dados'];
      return body.map((dynamic item) => Deputado.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load deputados');
    }
  }

  Future<List<Proposta>> fetchPropostas() async {
    final response = await http.get(Uri.parse('$baseUrlPropostas?ordem=ASC&ordenarPor=id'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['dados'];
      return body.map((dynamic item) => Proposta.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load propostas');
    }
  }

  Future<Proposta> fetchPropostaById(int id) async {
    final response = await http.get(Uri.parse('$baseUrlPropostas/$id'));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body)['dados'];
      return Proposta.fromJson(body);
    } else {
      throw Exception('Failed to load proposta with id: $id');
    }
  }
}
