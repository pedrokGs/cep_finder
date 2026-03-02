class CepFinderException implements Exception {
  @override
  String toString() {
    return "There was an error trying to connect to the api";
  }
}
