import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../core/config/custom_color.dart';
import '../../../../core/utils/screen_navigator.dart';
import '../../../../data/models/return_value_model.dart';
import '../../../cubit/cubits.dart';
import '../../../widgets/button/custom_button_label.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/custom_text_field.dart';
import '../../main/main_screen.dart';

class CreateWallet extends StatefulWidget {
  const CreateWallet({Key? key}) : super(key: key);

  @override
  _CreateWalletState createState() => _CreateWalletState();
}

class _CreateWalletState extends State<CreateWallet> {
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(controller: passwordController),
        CustomButtonLabel(label: "Buat Wallet", onTap: _createWallet),
      ],
    );
  }

  void _createWallet() async {
    // Check passwordController.text != ""
    if (passwordController.text.trim() != "") {
      CustomProgressDialog progressDialog = CustomProgressDialog(context);
      // Show progressDialog
      progressDialog.show();

      // Request create wallet
      final ReturnValueModel<Wallet> result = await context
          .read<WalletCubit>()
          .createWallet(password: passwordController.text);

      // Dismiss progressDialog
      progressDialog.dismiss();

      // Check result create wallet
      if (result.isSuccess) {
        // Success create wallet
        // Navigtor to mainScreen
        ScreenNavigator.removeAllScreen(context, MainScreen());
      } else {
        // Failed create wallet
        // Show toast
        CustomDialog.showToast(
          message: result.message,
          context: context,
          backgroundColor: UniversalColor.red,
        );
      }
    }
  }
}
