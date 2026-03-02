import 'package:cep_finder/src/exceptions/cep_finder_exception.dart';

/// Exception thrown when the provided CEP (ZIP code) string does not follow
/// the required numerical format.
class InvalidFormatException extends CepFinderException {
  @override
  String toString() {
    return "Cep is in an invalid format";
  }
}
