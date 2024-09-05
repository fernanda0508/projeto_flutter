class MembroPartido {
  final int id;
  final String nome;
  final String siglaPartido;
  final String siglaUf;
  final String urlFoto;

  MembroPartido({
    required this.id,
    required this.nome,
    required this.siglaPartido,
    required this.siglaUf,
    required this.urlFoto,
  });

  factory MembroPartido.fromJson(Map<String, dynamic> json) {
    return MembroPartido(
      id: json['id'],
      nome: json['nome'],
      siglaPartido: json['siglaPartido'],
      siglaUf: json['siglaUf'],
      urlFoto: json['urlFoto'],
    );
  }
}
