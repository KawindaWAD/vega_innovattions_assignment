import 'package:formz/formz.dart';

import '../../../../../core/functions/regular_expressions.dart';

enum EmailValidationErrorType {
  empty,
  invalid,
}

class EmailValidationError {
  final EmailValidationErrorType type;
  final String message;

  EmailValidationError({required this.type, required this.message});
}

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty(super.value) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    if(value.isEmpty) {
      return EmailValidationError(type: EmailValidationErrorType.empty, message: "Email should not empty");
    }
    if(!RegularExpressions.email.hasMatch(value)) {
      return EmailValidationError(type: EmailValidationErrorType.invalid, message: "Email not valid");
    }
    return null;
  }
}