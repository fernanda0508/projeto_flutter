class Proposta {
  final int id;
  final String? uri;
  final String? siglaTipo;
  final int? codTipo;
  final int? numero;
  final int? ano;
  final String ementa;
  final String? dataApresentacao;
  final String? uriOrgaoNumerador;
  final Map<String, dynamic>? statusProposta;
  final String? uriAutores;
  final String? descricaoTipo;
  final String? ementaDetalhada;
  final String? keywords;
  final String? urlInteiroTeor;
  final String? urnFinal;
  final String? texto;
  final String? justificativa;

  Proposta({
    required this.id,
    required this.uri,
    required this.siglaTipo,
    required this.codTipo,
    required this.numero,
    required this.ano,
    required this.ementa,
    required this.dataApresentacao,
    required this.uriOrgaoNumerador,
    required this.statusProposta,
    required this.uriAutores,
    required this.descricaoTipo,
    required this.ementaDetalhada,
    required this.keywords,
    required this.urlInteiroTeor,
    this.urnFinal,
    this.texto,
    this.justificativa,
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
      dataApresentacao: json['dataApresentacao'],
      uriOrgaoNumerador: json['uriOrgaoNumerador'],
      statusProposta: json['statusProposta'],
      uriAutores: json['uriAutores'],
      descricaoTipo: json['descricaoTipo'],
      ementaDetalhada: json['ementaDetalhada'],
      keywords: json['keywords'],
      urlInteiroTeor: json['urlInteiroTeor'],
      urnFinal: json['urnFinal'],
      texto: json['texto'],
      justificativa: json['justificativa'],
    );
  }
}
