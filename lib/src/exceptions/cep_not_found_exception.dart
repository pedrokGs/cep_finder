import 'package:cep_finder/src/exceptions/cep_finder_exception.dart';

/// Exception thrown when the API lookup is successful, but the provided CEP
/// does not exist in the api service
class CepNotFoundException extends CepFinderException {
  @override
  String toString() {
    return "Cep was not found";
  }
}
