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

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.screenHeight * 0.25,
        ),
        CustomTextField(controller: passwordController),
        CustomButtonLabel(label: "Masuk", onTap: _onLoading),
      ],
    );
  }

  void _onLoading() async {
    // Check passwordController != ""
    if (passwordController.text.trim() != "") {
      // hide keyBoard
      Utils.hideKeyboard(context);
      CustomProgressDialog progressDialog =
          CustomDialog.showCustomProgressDialog(context: context);
      // Show progressDialog
      progressDialog.show();

      // Process login wallet
      final ReturnValueModel<Wallet> result = await context
          .read<WalletCubit>()
          .login(password: passwordController.text);

      // Dimiss progressDialog
      progressDialog.dismiss();

      // Check result
      if (result.isSuccess) {
        // Login wallet Success
        // Navigator to MainScreen
        ScreenNavigator.removeAllScreen(context, MainScreen());
      } else {
        // Login wallet failed
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
