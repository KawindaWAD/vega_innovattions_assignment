import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:vega_innovattions_assignmen/core/presentation/custom_flush_bar.dart';
import 'package:vega_innovattions_assignmen/features/sign_up/data/models/form_models/phone_number_form_model.dart';

import '../../../core/presentation/widgets/main_button.dart';
import '../../../core/presentation/widgets/text_fild.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../../injector.dart';
import '../data/models/form_models/email_form_model.dart';
import '../data/models/form_models/name_form_model.dart';
import '../data/models/form_models/password_form_model.dart';
import 'bloc/sign_up_cubit.dart';
import 'bloc/sign_up_user/sign_up_user_bloc.dart';

class SignUpScreenWrapper extends StatelessWidget {
  const SignUpScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpCubit>(
          create: (context) => sl<SignUpCubit>(),
        ),
        BlocProvider<SignUpUserBloc>(
          create: (context) => sl<SignUpUserBloc>(),
        ),
      ],
      child: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpUserBloc, SignUpUserState>(
      listener: (context, state) {
        if(state.status == FormzStatus.submissionFailure) {
          CustomFlushBar.primary(context: context, message: state.failureMessage, title: "Registration failed", duration: const Duration(seconds: 6));
        }
        if(state.status == FormzStatus.submissionSuccess) {
          CustomFlushBar.primary(context: context, message: "Use your email and password to log in to the system next time", title: "Registration success", duration: const Duration(seconds: 6));
          //Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterLoginSuccessScreen(type: 'register')));
        }
      },
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
                    'Create new account',
                    style: headline1,
                  ),
                  10.verticalSpace,
                  const Text(
                    'Please fill in the form to continue',
                    style: headline3,
                  ),
                  60.verticalSpace,
                  BlocSelector<SignUpUserBloc, SignUpUserState, Name>(
                    selector: (state) {
                      return state.name;
                    },
                    builder: (context, name) {
                      return textField(
                        controller: context.read<SignUpCubit>().nameController,
                        keyBordType: TextInputType.name,
                        autofillHints: const [AutofillHints.name],
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        hintTxt: 'Full Name',
                        onChanged: (text) {
                          context.read<SignUpUserBloc>().add(NameChanged(text.trim()));
                        },
                        onSubmitted: (text) {
                          FocusScope.of(context).requestFocus(context.read<SignUpCubit>().emailNode);
                        },
                        isValid: name.pure? null : name.valid,
                        errorText: name.pure? null : name.error?.message,
                      );
                    },
                  ),
                  BlocSelector<SignUpUserBloc, SignUpUserState, Email>(
                    selector: (state) {
                      return state.email;
                    },
                    builder: (context, email) {
                      return textField(
                        controller: context.read<SignUpCubit>().emailController,
                        focusNode: context.read<SignUpCubit>().emailNode,
                        keyBordType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        textInputAction: TextInputAction.next,
                        hintTxt: 'Email Address',
                        onChanged: (text) {
                          context.read<SignUpUserBloc>().add(EmailChanged(text.trim()));
                        },
                        onSubmitted: (text) {
                          FocusScope.of(context).requestFocus(context.read<SignUpCubit>().phoneNumberNode);
                        },
                        isValid: email.pure? null : email.valid,
                        errorText: email.pure? null : email.error?.message,
                      );
                    },
                  ),
                  BlocSelector<SignUpUserBloc, SignUpUserState, PhoneNumber>(
                    selector: (state) {
                      return state.phoneNumber;
                    },
                    builder: (context, phoneNumber) {
                      return textField(
                        controller: context.read<SignUpCubit>().phoneNumberController,
                        focusNode: context.read<SignUpCubit>().phoneNumberNode,
                        keyBordType: TextInputType.phone,
                        autofillHints: const [AutofillHints.telephoneNumber],
                        textInputAction: TextInputAction.next,
                        hintTxt: 'Phone Number',
                        onChanged: (text) {
                          context.read<SignUpUserBloc>().add(PhoneNumberChanged(text.trim()));
                        },
                        onSubmitted: (text) {
                          FocusScope.of(context).requestFocus(context.read<SignUpCubit>().passwordNode);
                        },
                        isValid: phoneNumber.pure? null : phoneNumber.valid,
                        errorText: phoneNumber.pure? null : phoneNumber.error?.message,
                      );
                    },
                  ),
                  BlocSelector<SignUpUserBloc, SignUpUserState, Password>(
                    selector: (state) {
                      return state.password;
                    },
                    builder: (context, password) {
                      return textField(
                        controller: context.read<SignUpCubit>().passwordController,
                        focusNode: context.read<SignUpCubit>().passwordNode,
                        textInputAction: TextInputAction.done,
                        isObs: true,
                        hintTxt: 'Password',
                        onChanged: (text) {
                          context.read<SignUpUserBloc>().add(PasswordChanged(text.trim()));
                        },
                        isValid: password.pure? null : password.valid,
                        errorText: password.pure? null : password.error?.message,
                      );
                    },
                  ),
                  60.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BlocSelector<SignUpUserBloc, SignUpUserState, FormzStatus>(
                      selector: (state) {
                        return state.status;
                      },
                      builder: (context, status) {
                        return MainButton(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            context.read<SignUpUserBloc>().add(const RegistrationContinued());
                          },
                          text: 'Sign Up',
                          height: 60,
                          borderRadius: 20,
                          isLoading: status==FormzStatus.submissionInProgress? true : false,
                        );
                      },
                    ),
                  ),
                  20.verticalSpace,
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Have an account? ',
                          style: headline.copyWith(
                            fontSize: 14.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Sign In',
                          style: headlineDot.copyWith(
                            fontSize: 14.0,
                          ),
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
