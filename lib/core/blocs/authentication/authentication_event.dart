part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class LoggedIn extends AuthenticationEvent {
  final String token;
  final AuthenticationStatus authenticationStatus;

  const LoggedIn({
    required this.token,
    required this.authenticationStatus,
  });

  @override
  List<Object?> get props => [token];
}

class LoggedOut extends AuthenticationEvent {
  const LoggedOut();

  @override
  List<Object?> get props => [];
}