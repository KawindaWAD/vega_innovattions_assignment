part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  logOutInProgress,
}

class AuthenticationState extends Equatable {
  final String token;
  final AuthenticationStatus authenticationStatus;

  const AuthenticationState({
    this.token = '',
    this.authenticationStatus = AuthenticationStatus.unknown,
  });

  @override
  List<Object> get props => [token, authenticationStatus];

  AuthenticationState copyWith({
    String? token,
    AuthenticationStatus? authenticationStatus,
  }) {
    return AuthenticationState(
      token: token ?? this.token,
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
    );
  }
}
