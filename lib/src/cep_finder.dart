import 'dart:convert';

import 'package:cep_finder/src/models/cep_info.dart';
import 'package:cep_finder/src/exceptions/cep_finder_exception.dart';
import 'package:cep_finder/src/exceptions/cep_not_found_exception.dart';
import 'package:cep_finder/src/exceptions/invalid_format_exception.dart';
import 'package:http/http.dart' as http;

class CepFinder {
  final http.Client _httpClient;

  CepFinder({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<CepInfo> find(String cepCode) async {
    final cep = _cleanCepFormat(cepCode);

    final String cepRegex = r"^\d{8}$";
    if (!RegExp(cepRegex).hasMatch(cep)) {
      throw InvalidFormatException();
    }

    final uri = Uri.parse("https://viacep.com.br/ws/$cep/json/");
    try {
      final res = await _httpClient.get(uri);

      if (res.statusCode != 200) {
        throw CepFinderException();
      }

      final Map<String, dynamic> json = jsonDecode(res.body);
      if (json.containsKey("erro")) {
        throw CepNotFoundException();
      }

      return CepInfo.fromJson(json);

    } on CepNotFoundException catch (_) {
      rethrow;
    } catch (_) {
      throw CepFinderException();
    }
  }

  String _cleanCepFormat(String cep) {
    return cep.replaceAll(RegExp(r'[^0-9]'), '');
  }
}
