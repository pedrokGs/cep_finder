/// Base exception class for all errors related to the [CepFinder] operations.
/// thrown on a connection error with the api
class CepFinderException implements Exception {
  @override
  String toString() {
    return "There was an error trying to connect to the api";
  }
}
