class Partido {
  final int id;
  final String sigla;
  final String nome;
  final String uri;
  final String? urlLogo;
  final String? numeroEleitoral;
  final String? urlWebSite;
  final String? urlFacebook;
  final StatusPartido? status; // Torna status opcional

  Partido({
    required this.id,
    required this.sigla,
    required this.nome,
    required this.uri,
    this.status,
    this.urlLogo,
    this.numeroEleitoral,
    this.urlWebSite,
    this.urlFacebook,
  });

  factory Partido.fromJson(Map<String, dynamic> json) {
    return Partido(
      id: json['id'],
      sigla: json['sigla'],
      nome: json['nome'],
      uri: json['uri'],
      urlLogo: json['urlLogo'] ?? '',
      numeroEleitoral: json['numeroEleitoral'],
      urlWebSite: json['urlWebSite'],
      urlFacebook: json['urlFacebook'],
      status: json['status'] != null
          ? StatusPartido.fromJson(json['status'])
          : null, // Verifica se 'status' existe
    );
  }
}

class StatusPartido {
  final String data;
  final String idLegislatura;
  final String situacao;
  final String totalPosse;
  final String totalMembros;
  final String uriMembros;
  final LiderPartido lider;

  StatusPartido({
    required this.data,
    required this.idLegislatura,
    required this.situacao,
    required this.totalPosse,
    required this.totalMembros,
    required this.uriMembros,
    required this.lider,
  });

  factory StatusPartido.fromJson(Map<String, dynamic> json) {
    return StatusPartido(
      data: json['data'],
      idLegislatura: json['idLegislatura'],
      situacao: json['situacao'],
      totalPosse: json['totalPosse'],
      totalMembros: json['totalMembros'],
      uriMembros: json['uriMembros'],
      lider: LiderPartido.fromJson(json['lider']),
    );
  }
}

class LiderPartido {
  final String uri;
  final String nome;
  final String siglaPartido;
  final String uriPartido;
  final String uf;
  final int idLegislatura;
  final String urlFoto;

  LiderPartido({
    required this.uri,
    required this.nome,
    required this.siglaPartido,
    required this.uriPartido,
    required this.uf,
    required this.idLegislatura,
    required this.urlFoto,
  });

  factory LiderPartido.fromJson(Map<String, dynamic> json) {
    return LiderPartido(
      uri: json['uri'],
      nome: json['nome'],
      siglaPartido: json['siglaPartido'],
      uriPartido: json['uriPartido'],
      uf: json['uf'],
      idLegislatura: json['idLegislatura'],
      urlFoto: json['urlFoto'],
    );
  }
}
