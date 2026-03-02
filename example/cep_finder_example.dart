import 'package:cep_finder/cep_finder.dart';

void main() async {
  final finder = CepFinder();

  print('Searching for valid CEP');
  try {
    final info = await finder.find('01001-000');
    print('Logradouro: ${info.logradouro}');
    print('Cidade: ${info.localidade}');
    print('UF: ${info.uf}');
  } catch (e) {
    print('Erro: $e');
  }

  print('\nSearching for inexisting CEP');
  try {
    await finder.find('00000-000');
  } on CepNotFoundException {
    print('Erro: CEP não encontrado.');
  } catch (e) {
    print('Erro inesperado: $e');
  }

  print('\nSearching for malformed CEP');
  try {
    await finder.find('123');
  } on InvalidFormatException {
    print('Erro: Formato de CEP inválido.');
  } catch (e) {
    print('Erro inesperado: $e');
  }
}