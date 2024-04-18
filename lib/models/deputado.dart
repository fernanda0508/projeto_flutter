class Deputado {
  final int id;
  final String nome;
  final String siglaPartido;
  final String siglaUf;
  final String urlFoto;
  final String email;

  Deputado({
    required this.id,
    required this.nome,
    required this.siglaPartido,
    required this.siglaUf,
    required this.urlFoto,
    required this.email,
  });

  factory Deputado.fromJson(Map<String, dynamic> json) {
    return Deputado(
      id: json['id'],
      nome: json['nome'],
      siglaPartido: json['siglaPartido'],
      siglaUf: json['siglaUf'],
      urlFoto: json['urlFoto'],
      email: json['email'],
    );
  }
}
