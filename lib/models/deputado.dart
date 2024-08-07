// Classe Deputado define o modelo de dados para um deputado.
class Deputado {
  final int id;
  final String uri;
  final String nomeCivil;
  final String? cpf;
  final String? sexo;
  final String? urlWebsite;
  final List<String> redeSocial;
  final String? dataNascimento;
  final String? dataFalecimento;
  final String? ufNascimento;
  final String? municipioNascimento;
  final String? escolaridade;
  final UltimoStatus ultimoStatus;

  // Construtor da classe Deputado.
  Deputado({
    required this.id,
    required this.uri,
    required this.nomeCivil,
    this.cpf,
    this.sexo,
    this.urlWebsite,
    required this.redeSocial,
    this.dataNascimento,
    this.dataFalecimento,
    this.ufNascimento,
    this.municipioNascimento,
    this.escolaridade,
    required this.ultimoStatus,
  });

  // Fábrica para construir uma instância de Deputado a partir de um mapa JSON.
  factory Deputado.fromJson(Map<String, dynamic> json) {
    return Deputado(
      id: json['id'],
      uri: json['uri'] ?? '',
      nomeCivil: json['nomeCivil'] ?? '',
      cpf: json['cpf'],
      sexo: json['sexo'],
      urlWebsite: json['urlWebsite'],
      redeSocial: List<String>.from(json['redeSocial'] ?? []),
      dataNascimento: json['dataNascimento'],
      dataFalecimento: json['dataFalecimento'],
      ufNascimento: json['ufNascimento'],
      municipioNascimento: json['municipioNascimento'],
      escolaridade: json['escolaridade'],
      ultimoStatus: UltimoStatus.fromJson(json['ultimoStatus']),
    );
  }
}

// Classe UltimoStatus define o último status do deputado.
class UltimoStatus {
  final int id;
  final String uri;
  final String nome;
  final String? siglaPartido;
  final String? uriPartido;
  final String siglaUf;
  final int idLegislatura;
  final String urlFoto;
  final String? email;
  final String? data;
  final String nomeEleitoral;
  final Gabinete? gabinete;
  final String situacao;
  final String? condicaoEleitoral;
  final String? descricaoStatus;

  // Construtor da classe UltimoStatus.
  UltimoStatus({
    required this.id,
    required this.uri,
    required this.nome,
    this.siglaPartido,
    this.uriPartido,
    required this.siglaUf,
    required this.idLegislatura,
    required this.urlFoto,
    this.email,
    this.data,
    required this.nomeEleitoral,
    this.gabinete,
    required this.situacao,
    this.condicaoEleitoral,
    this.descricaoStatus,
  });

  // Fábrica para construir uma instância de UltimoStatus a partir de um mapa JSON.
  factory UltimoStatus.fromJson(Map<String, dynamic> json) {
    return UltimoStatus(
      id: json['id'],
      uri: json['uri'] ?? '',
      nome: json['nome'] ?? '',
      siglaPartido: json['siglaPartido'],
      uriPartido: json['uriPartido'],
      siglaUf: json['siglaUf'] ?? '',
      idLegislatura: json['idLegislatura'] ?? 0,
      urlFoto: json['urlFoto'] ?? '',
      email: json['email'],
      data: json['data'],
      nomeEleitoral: json['nomeEleitoral'] ?? '',
      gabinete:
          json['gabinete'] != null ? Gabinete.fromJson(json['gabinete']) : null,
      situacao: json['situacao'] ?? '',
      condicaoEleitoral: json['condicaoEleitoral'],
      descricaoStatus: json['descricaoStatus'],
    );
  }
}

// Classe Gabinete define os detalhes do gabinete do deputado.
class Gabinete {
  final String? nome;
  final String? predio;
  final String? sala;
  final String? andar;
  final String? telefone;
  final String? email;

  // Construtor da classe Gabinete.
  Gabinete({
    this.nome,
    this.predio,
    this.sala,
    this.andar,
    this.telefone,
    this.email,
  });

  // Fábrica para construir uma instância de Gabinete a partir de um mapa JSON.
  factory Gabinete.fromJson(Map<String, dynamic> json) {
    return Gabinete(
      nome: json['nome'],
      predio: json['predio'],
      sala: json['sala'],
      andar: json['andar'],
      telefone: json['telefone'],
      email: json['email'],
    );
  }
}
