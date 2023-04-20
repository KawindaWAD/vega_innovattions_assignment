import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vega_innovattions_assignmen/features/common/presentation/widgets/main_button.dart';

import '../../../core/functions/change_status_bar.dart';
import '../../../injector.dart';
import '../../common/presentation/blocs/authentication/authentication_bloc.dart';

class ProfileScreenWrapper extends StatelessWidget {
  const ProfileScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => sl<AuthenticationBloc>(),
        ),
      ],
      child: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: MainButton(
          text: 'Logout',
          onTap: () {
            _showLogoutAlert(context);
          },
        ),
      ),
    );
  }

  _showLogoutAlert(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout of your account?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                changeStatusBar(true);
                Navigator.pop(context);
                BlocProvider.of<AuthenticationBloc>(context).add(const LoggedOut());
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
