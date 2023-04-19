import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailNode = FocusNode();
  final FocusNode phoneNumberNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  SignUpCubit() : super(SignUpInitial());

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    phoneNumberNode.dispose();
    passwordNode.dispose();
    return super.close();
  }
}
