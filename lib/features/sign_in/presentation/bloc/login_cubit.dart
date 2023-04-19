import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode passwordNode = FocusNode();

  LoginCubit() : super(LoginInitial());

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    passwordNode.dispose();
    return super.close();
  }
}
