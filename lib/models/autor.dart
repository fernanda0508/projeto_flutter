class Autor {

  final String uri;
  final String nome;
  final int codTipo;
  final String tipo;
  final int ordemAssinatura;
  final int proponente;


  Autor({
    required this.uri,
    required this.nome,
    required this.codTipo,
    required this.tipo,
    required this.ordemAssinatura,
    required this.proponente,
  });

  factory Autor.fromJson(Map<String, dynamic> json) {
    return Autor(
      uri: json['uri'],
      nome: json['nome'],
      codTipo: json['codTipo'],
      tipo: json['tipo'],
      ordemAssinatura: json['ordemAssinatura'],
      proponente: json['proponente'],
    );
  }




}