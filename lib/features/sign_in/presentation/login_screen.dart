import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:vega_innovattions_assignmen/features/sign_up/data/models/form_models/password_form_model.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../../injector.dart';
import '../../common/presentation/blocs/authentication/authentication_bloc.dart';
import '../../common/presentation/custom_flush_bar.dart';
import '../../common/presentation/widgets/main_button.dart';
import '../../common/presentation/widgets/text_fild.dart';
import '../../sign_up/data/models/form_models/email_form_model.dart';
import '../../sign_up/presentation/sign_up_screen.dart';
import 'bloc/login_cubit.dart';
import 'bloc/login_user/login_user_bloc.dart';

class LoginScreenWrapper extends StatelessWidget {
  const LoginScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => sl<LoginCubit>(),
        ),
        BlocProvider<LoginUserBloc>(
          create: (context) => sl<LoginUserBloc>(),
        ),
      ],
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginUserBloc, LoginUserState>(
      listener: (context, state) {
        if(state.status == FormzStatus.submissionFailure) {
          CustomFlushBar.primary(context: context, message: state.failureMessage, title: "Login failed", duration: const Duration(seconds: 6));
        }
        if(state.status == FormzStatus.submissionSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(const LoggedIn(token: '', authenticationStatus: AuthenticationStatus.authenticated));
        }
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: AppColors.blackBG,
            body: Padding(
              padding: EdgeInsets.only(top: 50.0.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    50.verticalSpace,
                    const Text(
                      'Welcome Back!',
                      style: headline1,
                    ),
                    10.verticalSpace,
                    const Text(
                      'Please sign in to your account',
                      style: headline3,
                    ),
                    60.verticalSpace,
                    BlocSelector<LoginUserBloc, LoginUserState, Email>(
                      selector: (state) {
                        return state.email;
                      },
                      builder: (context, email) {
                        return textField(
                          controller: context.read<LoginCubit>().emailController,
                          keyBordType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          textInputAction: TextInputAction.next,
                          hintTxt: 'Email',
                          onChanged: (text) {
                            context.read<LoginUserBloc>().add(EmailChanged(text.trim()));
                          },
                          onSubmitted: (text) {
                            FocusScope.of(context).requestFocus(context.read<LoginCubit>().passwordNode);
                          },
                          isValid: email.pure? null : email.valid,
                          errorText: email.pure? null : email.error?.message,
                        );
                      },
                    ),
                    BlocSelector<LoginUserBloc, LoginUserState, Password>(
                      selector: (state) {
                        return state.password;
                      },
                      builder: (context, password) {
                        return textField(
                          controller: context.read<LoginCubit>().passwordController,
                          focusNode: context.read<LoginCubit>().passwordNode,
                          textInputAction: TextInputAction.done,
                          isObs: true,
                          hintTxt: 'Password',
                          onChanged: (text) {
                            context.read<LoginUserBloc>().add(PasswordChanged(text.trim()));
                          },
                          isValid: password.pure? null : password.valid,
                          errorText: password.pure? null : password.error?.message,
                        );
                      },
                    )
                    ,
                    10.verticalSpace,
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.0.w),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: headline3,
                          ),
                        ),
                      ),
                    ),
                    100.verticalSpace,
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: BlocSelector<LoginUserBloc, LoginUserState, FormzStatus>(
                              selector: (state) {
                                return state.status;
                              },
                              builder: (context, status) {
                                return MainButton(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    context.read<LoginUserBloc>().add(const LoginRequested());
                                  },
                                  text: 'Sign in',
                                  height: 60,
                                  isLoading: status==FormzStatus.submissionInProgress? true : false,
                                );
                              },
                            )
                            ,
                          ),
                          20.verticalSpace,
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => const SignUpScreenWrapper()));
                            },
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Don\' have an account? ',
                                  style: headline.copyWith(
                                    fontSize: 14.0,
                                  ),
                                ),
                                TextSpan(
                                  text: ' Sign Up',
                                  style: headlineDot.copyWith(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ]),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
