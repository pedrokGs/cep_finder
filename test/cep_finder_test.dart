import 'dart:convert';

import 'package:cep_finder/src/cep_finder.dart';
import 'package:cep_finder/src/exceptions/cep_finder_exception.dart';
import 'package:cep_finder/src/exceptions/cep_not_found_exception.dart';
import 'package:cep_finder/src/exceptions/invalid_format_exception.dart';
import 'package:cep_finder/src/models/cep_info.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late CepFinder cepFinder;

  setUp(() {
    mockHttpClient = MockHttpClient();
    cepFinder = CepFinder(httpClient: mockHttpClient);
    registerFallbackValue(Uri.parse('https://viacep.com.br/ws/00000000/json'));
  });

  group('CepFinder - find', () {
    const validCep = '01001-000';
    const cleanedCep = '01001000';
    final mockUrl = Uri.parse('viacep.com.br/ws/$cleanedCep/json');

    test('should return CepInfo when the call is successful', () async {
      final mockResponse = {
        "cep": "01001-000",
        "logradouro": "Praça da Sé",
        "localidade": "São Paulo",
        "uf": "SP"
      };

      when(() => mockHttpClient.get(mockUrl))
          .thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

      final result = await cepFinder.find(validCep);

      expect(result, isA<CepInfo>());
      expect(result.logradouro, 'Praça da Sé');
      verify(() => mockHttpClient.get(mockUrl)).called(1);
    });

    test('should throw InvalidFormatException when CEP format is invalid', () async {
      const invalidCep = '123-ABC';

      expect(() => cepFinder.find(invalidCep), throwsA(isA<InvalidFormatException>()));
      verifyNever(() => mockHttpClient.get(any()));
    });

    test('should throw CepNotFoundException when ViaCEP returns an error', () async {
      const nonExistentCep = '00000000';
      final errorUrl = Uri.parse('viacep.com.br/ws/$nonExistentCep/json');

      when(() => mockHttpClient.get(errorUrl))
          .thenAnswer((_) async => http.Response('{"erro": true}', 200));

      expect(() => cepFinder.find(nonExistentCep), throwsA(isA<CepNotFoundException>()));
    });

    test('should throw CepFinderException when Http client throws exception', () async {
      when(() => mockHttpClient.get(any()))
          .thenThrow(Exception('Network error'));

      expect(() => cepFinder.find(validCep), throwsA(isA<CepFinderException>()));
    });
  });
}