class CepInfo {
  final String cep;
  final String logradouro;
  final String complemento;
  final String unidade;
  final String bairro;
  final String localidade;
  final String uf;
  final String estado;
  final String regiao;
  final int ibge;
  final int gia;
  final int ddd;
  final int siafi;

  const CepInfo({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.unidade,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.estado,
    required this.regiao,
    required this.ibge,
    required this.gia,
    required this.ddd,
    required this.siafi,
  });

  factory CepInfo.fromJson(Map<String, dynamic> json) => CepInfo(
    cep: json["cep"] ?? "",
    logradouro: json["logradouro"] ?? "",
    complemento: json["complemento"] ?? "",
    unidade: json["unidade"] ?? "",
    bairro: json["bairro"] ?? "",
    localidade: json["localidade"] ?? "",
    uf: json["uf"] ?? "",
    estado: json["estado"] ?? "",
    regiao: json["regiao"] ?? "",
    ibge: int.tryParse(json["ibge"] ?? "") ?? 0,
    gia: int.tryParse(json["gia"] ?? "") ?? 0,
    ddd: int.tryParse(json["ddd"] ?? "") ?? 0,
    siafi: int.tryParse(json["siafi"] ?? "") ?? 0,
  );
}
