import 'package:formz/formz.dart';

enum CellphoneValidationError { empty, invalid }

class Cellphone extends FormzInput<String, CellphoneValidationError> {
  const Cellphone.pure() : super.pure('');

  const Cellphone.dirty([super.value = '']) : super.dirty();

  @override
  CellphoneValidationError? validator(String value) {
    if (value.isEmpty) {
      return CellphoneValidationError.empty;
    } else if (value.length < 13) {
      return CellphoneValidationError.invalid;
    }

    return null;
  }
}
