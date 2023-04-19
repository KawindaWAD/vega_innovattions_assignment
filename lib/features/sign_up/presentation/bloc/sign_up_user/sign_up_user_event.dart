part of 'sign_up_user_bloc.dart';

abstract class SignUpUserEvent extends Equatable {
  const SignUpUserEvent();
}

class NameChanged extends SignUpUserEvent {
  final String name;

  const NameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class EmailChanged extends SignUpUserEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class PhoneNumberChanged extends SignUpUserEvent {
  final String phoneNumber;

  const PhoneNumberChanged(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class PasswordChanged extends SignUpUserEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class RegistrationContinued extends SignUpUserEvent {

  const RegistrationContinued();

  @override
  List<Object?> get props => [];
}