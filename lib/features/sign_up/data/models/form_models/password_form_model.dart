import 'package:formz/formz.dart';
import '../../../../../core/functions/regular_expressions.dart';

enum PasswordValidationErrorType {
  empty,
  invalidLength
}

class PasswordValidationError {
  final PasswordValidationErrorType? type;
  final String? message;

  PasswordValidationError({this.type, this.message});
}

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty(super.value) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if(value.isEmpty) {
      return PasswordValidationError(type: PasswordValidationErrorType.empty, message: "Password should not empty");
    }
    if(value.length<8) {
      return PasswordValidationError(type: PasswordValidationErrorType.invalidLength, message: "Enter at least 8 characters");
    }
    return null;
  }
}