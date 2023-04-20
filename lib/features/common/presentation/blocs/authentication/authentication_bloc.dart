import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../../../core/functions/change_status_bar.dart';
import '../event_transformer.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState()) {
    on<LoggedIn>(_loggedIn, transformer: Transformer.throttleDroppable());
    on<LoggedOut>(_loggedOut, transformer: Transformer.throttleDroppable());
  }

  FutureOr<void> _loggedIn(LoggedIn event, Emitter<AuthenticationState> emit) {
    changeStatusBar(false);
    emit(state.copyWith(
        authenticationStatus: event.authenticationStatus,
        token: event.token));
  }

  Future<FutureOr<void>> _loggedOut(LoggedOut event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(
      authenticationStatus: AuthenticationStatus.logOutInProgress,
    ));

    await Future.delayed(const Duration(seconds: 3));

    emit(state.copyWith(
      authenticationStatus: AuthenticationStatus.unauthenticated,
    ));
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    AuthenticationStatus authStatus = AuthenticationStatus.unknown;

    String authStatusString = json['authenticationStatus'];
    if (authStatusString == 'AuthenticationStatus.authenticated') {
      authStatus = AuthenticationStatus.authenticated;
    } else if (authStatusString == 'AuthenticationStatus.unauthenticated') {
      authStatus = AuthenticationStatus.unauthenticated;
    } else {
      authStatus = AuthenticationStatus.unknown;
    }

    return AuthenticationState(
      token: json['token'],
      authenticationStatus: authStatus,
    );
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    return {
      'token': state.token,
      'authenticationStatus': state.authenticationStatus.toString(),
    };
  }
}
