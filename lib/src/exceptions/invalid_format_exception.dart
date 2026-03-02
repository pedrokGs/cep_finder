import 'package:cep_finder/src/exceptions/cep_finder_exception.dart';

class InvalidFormatException extends CepFinderException {
  @override
  String toString() {
    return "Cep is in an invalid format";
  }
}
