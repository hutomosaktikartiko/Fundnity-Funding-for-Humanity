import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/utils.dart';
import '../../../shared/config/size_config.dart';
import '../../cubit/cubits.dart';
import 'widgets/body/create_wallet.dart';
import 'widgets/body/import_wallet.dart';
import 'widgets/body/login_body.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
          child: GestureDetector(
            onTap: () => Utils.hideKeyboard(context),
            onPanDown: (_) => Utils.hideKeyboard(context),
            child: BlocBuilder<AuthBodyCubit, AuthBodyState>(
              builder: (context, state) {
                if (state is AuthBodyLogin) {
                  return LoginBody();
                } else if (state is AuthBodyImportWallet) {
                  return ImportWallet();
                } else {
                  return CreateWallet();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
