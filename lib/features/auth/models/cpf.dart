import 'package:brasil_fields/brasil_fields.dart';
import 'package:formz/formz.dart';

enum CPFValidationError { empty, invalid }

class Cpf extends FormzInput<String, CPFValidationError> {
  const Cpf.pure() : super.pure('');

  const Cpf.dirty([super.value = '']) : super.dirty();

  @override
  CPFValidationError? validator(String value) {
    if (value.isEmpty) {
      return CPFValidationError.empty;
    } else if (!CPFValidator.isValid(value)) {
      return CPFValidationError.invalid;
    }

    return null;
  }
}
