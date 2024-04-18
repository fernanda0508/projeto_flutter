class Proposta {
  final int id;
  final String uri;
  final String siglaTipo;
  final int codTipo;
  final int numero;
  final int ano;
  final String ementa;

  Proposta({
    required this.id,
    required this.uri,
    required this.siglaTipo,
    required this.codTipo,
    required this.numero,
    required this.ano,
    required this.ementa,
  });

  factory Proposta.fromJson(Map<String, dynamic> json) {
    return Proposta(
      id: json['id'],
      uri: json['uri'],
      siglaTipo: json['siglaTipo'],
      codTipo: json['codTipo'],
      numero: json['numero'],
      ano: json['ano'],
      ementa: json['ementa'],
    );
  }
}
