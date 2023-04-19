import 'package:formz/formz.dart';
import '../../../../../core/functions/regular_expressions.dart';

enum NameValidationErrorType {
  empty,
  invalidCharacters,
  invalidLength
}

class NameValidationError {
  final NameValidationErrorType? type;
  final String? message;

  NameValidationError({this.type, this.message});
}

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty(super.value) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    if(value.isEmpty) {
      return NameValidationError(type: NameValidationErrorType.empty, message: "Name should not empty");
    }
    if(value.length<2) {
      return NameValidationError(type: NameValidationErrorType.invalidLength, message: "Enter at least two characters");
    }
    if(!RegularExpressions.fullName.hasMatch(value)) {
      return NameValidationError(type: NameValidationErrorType.invalidCharacters, message: "Enter valid name");
    }
    return null;
  }
}