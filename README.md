# CepFinder

A simple and efficient Dart/Flutter library for fetching address data using the ViaCEP API.

## Features

* Fetches full address details by CEP (Brazilian ZIP code).
* Specific error handling for CEPs not found.
* Supports multiple formats for cep input. ('01001-000', '01001000')

## Installation

Add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  cep_finder: ^1.0.0
```

## Usage

Here is a basic example of how to use the package:
```dart
import 'package:cep_finder/cep_finder.dart';

void main() async {
  final finder = CepFinder();

  try {
    final info = await finder.buscarCep("01001000");
    print("Address: ${info.logradouro}, ${info.localidade} - ${info.uf}");
    print("DDD: ${info.ddd}");
  } on CepNotFoundException {
    print("CEP not found.");
  } catch (e) {
    print("An unexpected error occurred: $e");
  }
}
```

## Error Handling
The package includes custom exceptions to make error handling easier in your code:

* ```CepNotFoundException```: Thrown when the API returns that the CEP does not exist.
* ```InvalidFormatException```: Thrown when the CEP format is invalid or malformed.
* ```CepFinderException```: Thrown for generic errors (connection failure, API error, etc.).

## License
This project is licensed under the MIT license - see the [LICENSE](LICENSE) file for details.