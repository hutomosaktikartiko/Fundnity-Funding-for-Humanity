import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_body/auth_body_cubit.dart';
import 'widgets/body/create_pin_body.dart';
import 'widgets/body/create_wallet_body.dart';
import 'widgets/body/import_wallet_body.dart';
import 'widgets/body/pin_verification_body.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBodyCubit, AuthBodyState>(
      builder: (context, state) {
        if (state is AuthBodyPinVerification) {
          return PinVerificationBody();
        } else if (state is AuthBodyImportWallet) {
          return ImportWalletBody();
        } else if (state is AuthBodyCreateWallet) {
          return CreateWalletBody();
        } else {
          return CreatePinBody();
        }
      },
    );
  }
}
