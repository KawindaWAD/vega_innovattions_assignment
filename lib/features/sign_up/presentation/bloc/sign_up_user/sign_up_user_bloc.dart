import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../common/presentation/blocs/event_transformer.dart';
import '../../../data/models/form_models/email_form_model.dart';
import '../../../data/models/form_models/name_form_model.dart';
import '../../../data/models/form_models/password_form_model.dart';
import '../../../data/models/form_models/phone_number_form_model.dart';
import '../../../domain/usecases/register_user.dart';

part 'sign_up_user_event.dart';
part 'sign_up_user_state.dart';

class SignUpUserBloc extends Bloc<SignUpUserEvent, SignUpUserState> {
  RegisterUser registerUser;

  SignUpUserBloc({required this.registerUser}) : super(const SignUpUserState()) {
    on<NameChanged>(_nameChanged);
    on<EmailChanged>(_emailChanged);
    on<PhoneNumberChanged>(_phoneNumberChanged);
    on<PasswordChanged>(_passwordChanged);
    on<RegistrationContinued>(_registrationContinued, transformer: Transformer.throttleDroppable());
  }

  FutureOr<void> _nameChanged(NameChanged event, Emitter<SignUpUserState> emit) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(
        name: name,
        status: Formz.validate([name, state.email, state.password, state.phoneNumber])
    ));
  }

  FutureOr<void> _emailChanged(EmailChanged event, Emitter<SignUpUserState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
        email: email,
        status: Formz.validate([state.name, email, state.password, state.phoneNumber])
    ));
  }

  FutureOr<void> _phoneNumberChanged(PhoneNumberChanged event, Emitter<SignUpUserState> emit) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(state.copyWith(
        phoneNumber: phoneNumber,
        status: Formz.validate([state.name, state.email, state.password, phoneNumber])
    ));
  }

  FutureOr<void> _passwordChanged(PasswordChanged event, Emitter<SignUpUserState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
        password: password,
        status: Formz.validate([state.name, state.email, state.phoneNumber, password])
    ));
  }

  Future<FutureOr<void>> _registrationContinued(RegistrationContinued event, Emitter<SignUpUserState> emit) async {
    if(state.status == FormzStatus.submissionFailure) {
      emit(state.copyWith(
          status: Formz.validate([state.name, state.email, state.password, state.phoneNumber])
      ));
    }

    // Display error texts on form fields if the form data are not completed
    if(state.status == FormzStatus.pure || state.status == FormzStatus.invalid) {
      final name = Name.dirty(state.name.value);
      final email = Email.dirty(state.email.value);
      final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
      final password = Password.dirty(state.password.value);

      emit(state.copyWith(
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          password: password,
          status: Formz.validate([name, email, password, phoneNumber])
      ));
    }
    // Call registration api if form data are completed
    if(state.status == FormzStatus.valid) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      UserRegistrationInfo info = UserRegistrationInfo(name: state.name.value, email: state.email.value, phoneNumber: state.phoneNumber.value, password: state.password.value);
      await Future.delayed(const Duration(seconds: 2));
      Either<Failure, bool> result = await registerUser(info);
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
