import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_body/auth_body_cubit.dart';
import 'widgets/body/create_wallet.dart';
import 'widgets/body/import_wallet.dart';
import 'widgets/body/login_body.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBodyCubit, AuthBodyState>(
      builder: (context, state) {
        if (state is AuthBodyLogin) {
          return LoginBody();
        } else if (state is AuthBodyImportWallet) {
          return ImportWallet();
        } else {
          return CreateWallet();
        }
      },
    );
  }
}
