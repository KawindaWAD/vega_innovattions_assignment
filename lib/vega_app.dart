import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vega_innovattions_assignmen/core/utils/colors.dart';

import 'features/common/presentation/blocs/authentication/authentication_bloc.dart';
import 'features/home/presentation/home.dart';
import 'features/sign_in/presentation/login_screen.dart';
import 'injector.dart';

class VegaApp extends StatelessWidget {
  const VegaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => sl<AuthenticationBloc>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) => _authListener(context, state),
              child: _getNextScreen(context),
            ),
          );
        },
      ),
    );
  }

  /// Navigate to next screen base on user authentication and device type
  Widget _getNextScreen(BuildContext context) {
    AuthenticationStatus authState =  context.read<AuthenticationBloc>().state.authenticationStatus;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: authState == AuthenticationStatus.authenticated? AppColors.white : Colors.transparent,
        statusBarIconBrightness: authState == AuthenticationStatus.authenticated? Brightness.dark : Brightness.light,
      ),
    );

    switch(authState) {
      case AuthenticationStatus.authenticated: return const HomeScreenWrapper();
      default: return const LoginScreenWrapper();
    }
  }

  /// User will redirect to the login screen when the user session expired or user logout
  void _authListener(BuildContext context, AuthenticationState state) {
    switch (state.authenticationStatus) {
      case AuthenticationStatus.authenticated: Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreenWrapper() ), (route) => route.isFirst);
      break;
      case AuthenticationStatus.logOutInProgress: {
        EasyLoading.show(status: "Login out!", dismissOnTap: false);
      }
      break;
      case AuthenticationStatus.unauthenticated: {
        EasyLoading.dismiss();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreenWrapper(),), (route) => route.isFirst);
      }
      break;
      default: null;
    }
  }
}
