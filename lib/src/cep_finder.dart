import 'dart:convert';

import 'package:cep_finder/src/models/cep_info.dart';
import 'package:cep_finder/src/exceptions/cep_finder_exception.dart';
import 'package:cep_finder/src/exceptions/cep_not_found_exception.dart';
import 'package:cep_finder/src/exceptions/invalid_format_exception.dart';
import 'package:http/http.dart' as http;

/// A client class responsible for fetching address information based on a ZIP code (CEP).
///
/// It uses the ViaCEP API to perform the lookup.
class CepFinder {
  final http.Client _httpClient;

  /// Creates a [CepFinder] instance.
  CepFinder({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  /// Fetches information for a specific [cepCode].
  ///
  /// The [cepCode] string can contain special characters like hyphens or dots,
  /// which will be automatically removed before the request.
  ///
  /// Returns a [CepInfo] object containing the address data.
  ///
  /// Throws [InvalidFormatException] if the CEP does not have 8 numerical digits.
  /// Throws [CepNotFoundException] if the CEP does not exist in the ViaCEP database.
  /// Throws [CepFinderException] if a network error occurs.
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

  /// Removes all non-numeric characters from a CEP string.
  String _cleanCepFormat(String cep) {
    return cep.replaceAll(RegExp(r'[^0-9]'), '');
  }
}
