part of 'sign_up_user_bloc.dart';

class SignUpUserState extends Equatable {
  final FormzStatus status;
  final Name name;
  final Email email;
  final PhoneNumber phoneNumber;
  final Password password;
  final String failureMessage;

  const SignUpUserState({
    this.status = FormzStatus.pure,
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.password = const Password.pure(),
    this.failureMessage = ''
  });

  @override
  List<Object> get props =>
      [status, name, email, phoneNumber, password, failureMessage,];

  SignUpUserState copyWith({
    FormzStatus? status,
    Name? name,
    Email? email,
    PhoneNumber? phoneNumber,
    Password? password,
    String? failureMessage,
  }) {
    return SignUpUserState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}
