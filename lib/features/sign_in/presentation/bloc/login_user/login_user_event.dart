part of 'login_user_bloc.dart';

abstract class LoginUserEvent extends Equatable {
  const LoginUserEvent();
}

class EmailChanged extends LoginUserEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends LoginUserEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class LoginRequested extends LoginUserEvent {

  const LoginRequested();

  @override
  List<Object?> get props => [];
}