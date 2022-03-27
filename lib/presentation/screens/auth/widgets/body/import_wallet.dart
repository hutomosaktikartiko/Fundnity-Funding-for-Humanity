import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../core/utils/screen_navigator.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../data/models/return_value_model.dart';
import '../../../../../shared/config/custom_color.dart';
import '../../../../../shared/config/custom_text_style.dart';
import '../../../../../shared/widgets/button/custom_button_label.dart';
import '../../../../../shared/widgets/custom_dialog.dart';
import '../../../../../shared/widgets/custom_text_field.dart';
import '../../../../cubit/cubits.dart';
import '../../../main/main_screen.dart';
import '../custom_back_button.dart';
import '../decription_text.dart';
import '../label_text.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomBackButton(
          onTap: () =>
              context.read<AuthBodyCubit>().emit(AuthBodyLogin()),
        ),
        LabelText(
          text: "Import Wallet",
        ),
        SizedBox(
          height: 6,
        ),
        DescriptionText(
            text: "Import file wallet anda, file dalam bentuk UTC atau JSON"),
        SizedBox(
          height: 22,
        ),
        CustomButtonLabel(
          label: walletFile?.path ?? "Pilih Wallet (UTC/JSON) file",
          backgroundColor: (walletFile != null)
              ? UniversalColor.gray4
              : UniversalColor.green4,
          borderColor: Colors.transparent,
          onTap: _selectFile,
        ),
        SizedBox(
          height: 6,
        ),
        CustomTextField(
          controller: passwordController,
          hintText: "Masukan password",
        ),
        SizedBox(
          height: 10,
        ),
        CustomButtonLabel(label: "Masuk", onTap: _onLoading),
        SizedBox(
          height: 22,
        ),
        Center(
          child: GestureDetector(
            onTap: () =>
                context.read<AuthBodyCubit>().emit(AuthBodyCreateWallet()),
            child: Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "Buat wallet baru? ",
                  ),
                  TextSpan(
                    text: "buat wallet",
                    style: CustomTextStyle.green4TextStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
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
