import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../core/config/custom_color.dart';
import '../../../../core/config/size_config.dart';
import '../../../../core/utils/screen_navigator.dart';
import '../../../../core/utils/utils.dart';
import '../../../../data/models/return_value_model.dart';
import '../../../cubit/cubits.dart';
import '../../../widgets/button/custom_button_label.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/custom_text_field.dart';
import '../../main/main_screen.dart';

class ImportWallet extends StatefulWidget {
  const ImportWallet({Key? key}) : super(key: key);

  @override
  _ImportWalletState createState() => _ImportWalletState();
}

class _ImportWalletState extends State<ImportWallet> {
  TextEditingController passwordController = TextEditingController();
  File? walletFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.screenHeight * 0.25,
        ),
        CustomButtonLabel(label: "Import Json File", onTap: _selectFile),
        CustomTextField(controller: passwordController),
        CustomButtonLabel(label: "Masuk", onTap: _onLoading),
      ],
    );
  }

  void _selectFile() async {
    // Select file
    File? result = await Utils.selectFile();
    // Check selectFile result
    if (result != null) {
      // Select File != null
      // set result to walletFile
      setState(() {
        walletFile = result;
      });
    }
  }

  void _onLoading() async {
    // Check walletFile != null
    // & passwordController != ""
    if (walletFile != null && passwordController.text.trim() != "") {
      // hide keyBoard
      Utils.hideKeyboard(context);
      CustomProgressDialog progressDialog =
          CustomDialog.showCustomProgressDialog(context: context);
      // Show progressDialog
      progressDialog.show();

      // Process importWallet
      final ReturnValueModel<Wallet> result = await context
          .read<WalletCubit>()
          .importWallet(file: walletFile!, password: passwordController.text);

      // Dimiss progressDialog
      progressDialog.dismiss();

      // Check result
      if (result.isSuccess) {
        // Import Wallet Success
        // Navigator to MainScreen
        ScreenNavigator.removeAllScreen(context, MainScreen());
      } else {
        // Import Wallet failed
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
