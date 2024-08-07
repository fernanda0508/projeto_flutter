// Classe Deputado define o modelo de dados para um deputado.
class DeputadoGet {
  // Definição de campos que representam as propriedades de um deputado.
  final int id;
  final String nome;
  final String siglaPartido;
  final String siglaUf;
  final String urlFoto;
  final String email;

  // Construtor da classe Deputado. Todos os campos são obrigatórios.
  DeputadoGet({
    required this.id,
    required this.nome,
    required this.siglaPartido,
    required this.siglaUf,
    required this.urlFoto,
    required this.email,
  });

  // Fábrica para construir uma instância de Deputado a partir de um mapa JSON.
  // Este método é usado para deserializar os dados recebidos de uma API externa.
  factory DeputadoGet.fromJson(Map<String, dynamic> json) {
    // Retorna uma nova instância de Deputado utilizando os dados extraídos do JSON.
    return DeputadoGet(
      id: json['id'],
      nome: json['nome'],
      siglaPartido: json['siglaPartido'],
      siglaUf: json['siglaUf'],
      urlFoto: json['urlFoto'],
      email: json['email'],
    );
  }
}
