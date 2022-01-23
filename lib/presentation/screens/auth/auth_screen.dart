import 'package:crowdfunding/core/config/size_config.dart';
import 'package:crowdfunding/core/utils/utils.dart';
import 'package:crowdfunding/presentation/cubit/cubits.dart';
import 'package:crowdfunding/presentation/screens/auth/widgets/create_wallet.dart';
import 'package:crowdfunding/presentation/screens/auth/widgets/import_wallet.dart';
import 'package:crowdfunding/presentation/screens/auth/widgets/login_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
