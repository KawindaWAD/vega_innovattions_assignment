part of 'login_user_bloc.dart';

class LoginUserState extends Equatable {
  final FormzStatus status;
  final Email email;
  final Password password;
  final String failureMessage;

  const LoginUserState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.failureMessage = ''
  });

  @override
  List<Object> get props => [status, email, password, failureMessage];

  LoginUserState copyWith({
    FormzStatus? status,
    Email? email,
    Password? password,
    String? failureMessage,
  }) {
    return LoginUserState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }
}