// lib/models/despesa.dart

class Despesa {
  final int ano;
  final int mes;
  final String tipoDespesa;
  final int codDocumento;
  final String tipoDocumento;
  final String dataDocumento;
  final String numDocumento;
  final double valorDocumento;
  final String urlDocumento;
  final String nomeFornecedor;
  final String cnpjCpfFornecedor;
  final double valorLiquido;
  final double valorGlosa;
  final String numRessarcimento;
  final int codLote;
  final int parcela;

  Despesa({
    required this.ano,
    required this.mes,
    required this.tipoDespesa,
    required this.codDocumento,
    required this.tipoDocumento,
    required this.dataDocumento,
    required this.numDocumento,
    required this.valorDocumento,
    required this.urlDocumento,
    required this.nomeFornecedor,
    required this.cnpjCpfFornecedor,
    required this.valorLiquido,
    required this.valorGlosa,
    required this.numRessarcimento,
    required this.codLote,
    required this.parcela,
  });

  factory Despesa.fromJson(Map<String, dynamic> json) {
    return Despesa(
      ano: json['ano'],
      mes: json['mes'],
      tipoDespesa: json['tipoDespesa'],
      codDocumento: json['codDocumento'],
      tipoDocumento: json['tipoDocumento'],
      dataDocumento: json['dataDocumento'],
      numDocumento: json['numDocumento'],
      valorDocumento: json['valorDocumento'].toDouble(),
      urlDocumento: json['urlDocumento'] ?? '',
      nomeFornecedor: json['nomeFornecedor'],
      cnpjCpfFornecedor: json['cnpjCpfFornecedor'],
      valorLiquido: json['valorLiquido'].toDouble(),
      valorGlosa: json['valorGlosa'].toDouble(),
      numRessarcimento: json['numRessarcimento'] ?? '',
      codLote: json['codLote'],
      parcela: json['parcela'],
    );
  }
}
