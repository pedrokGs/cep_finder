import 'package:cep_finder/src/exceptions/cep_finder_exception.dart';

class CepNotFoundException extends CepFinderException {
  @override
  String toString() {
    return "Cep was not found";
  }
}
