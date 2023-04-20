import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:vega_innovattions_assignmen/features/sign_in/domain/entities/user_details_entity.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../common/presentation/blocs/event_transformer.dart';
import '../../../../sign_up/data/models/form_models/email_form_model.dart';
import '../../../../sign_up/data/models/form_models/password_form_model.dart';
import '../../../domain/usecases/login_user.dart';

part 'login_user_event.dart';
part 'login_user_state.dart';

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  LoginUser loginUser;

  LoginUserBloc({required this.loginUser}) : super(const LoginUserState()) {
    on<EmailChanged>(_emailChanged);
    on<PasswordChanged>(_passwordChanged);
    on<LoginRequested>(_loginRequested, transformer: Transformer.throttleDroppable());
  }

  FutureOr<void> _emailChanged(EmailChanged event, Emitter<LoginUserState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
        email: email,
        status: Formz.validate([email, state.password])
    ));
  }

  FutureOr<void> _passwordChanged(PasswordChanged event, Emitter<LoginUserState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
        password: password,
        status: Formz.validate([state.email, password])
    ));
  }

  Future<FutureOr<void>> _loginRequested(LoginRequested event, Emitter<LoginUserState> emit) async {
    if(state.status == FormzStatus.submissionFailure) {
      emit(state.copyWith(
          status: Formz.validate([state.email, state.password,])
      ));
    }

    // Display error texts on form fields if the form data are not completed
    if(state.status == FormzStatus.pure || state.status == FormzStatus.invalid) {
      final email = Email.dirty(state.email.value);
      final password = Password.dirty(state.password.value);

      emit(state.copyWith(
          email: email,
          password: password,
          status: Formz.validate([email, password])
      ));
    }
    // Call registration api if form data are completed
    if(state.status == FormzStatus.valid) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      LoginDetails info = LoginDetails(email: state.email.value, password: state.password.value);
      await Future.delayed(const Duration(seconds: 2));
      Either<Failure, UserDetails> result = await loginUser(info);
      result.fold((failure) {
        String message = '';
        if(failure is ServerFailure) {
          message = failure.message;
        } else {
          message = "Something went wrong!";
        }
        emit(state.copyWith(status: FormzStatus.submissionFailure, failureMessage: message));
      }, (res) => emit(state.copyWith(status: FormzStatus.submissionSuccess)) );

    }
  }
}
