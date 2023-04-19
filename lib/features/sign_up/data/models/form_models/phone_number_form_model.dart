import 'package:formz/formz.dart';

import '../../../../../core/functions/regular_expressions.dart';

enum PhoneNumberValidationErrorType {
  empty,
  invalid,
  invalidCharacters,
}

class PhoneNumberValidationError {
  final PhoneNumberValidationErrorType type;
  final String message;

  PhoneNumberValidationError({required this.type, required this.message});
}

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty(super.value) : super.dirty();

  @override
  PhoneNumberValidationError? validator(String value) {
    if(value.isEmpty) {
      return PhoneNumberValidationError(type: PhoneNumberValidationErrorType.empty, message: "Phone number should not empty");
    } 
    if(!RegularExpressions.phoneNumber.hasMatch(value)) {
      return PhoneNumberValidationError(type: PhoneNumberValidationErrorType.invalidCharacters, message: "Number not valid");
    }
    if(value.startsWith("+") && value.length<12) {
      return PhoneNumberValidationError(type: PhoneNumberValidationErrorType.invalid, message: "Number not valid");
    }
    if(value.startsWith("0") && value.length<10) {
      return PhoneNumberValidationError(type: PhoneNumberValidationErrorType.invalid, message: "Number not valid");
    }
    return null;
  }
}