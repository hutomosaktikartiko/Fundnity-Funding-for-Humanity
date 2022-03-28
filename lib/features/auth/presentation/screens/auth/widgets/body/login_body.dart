import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../core/models/return_value_model.dart';
import '../../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../presentation/screens/main/main_screen.dart';
import '../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../shared/config/size_config.dart';
import '../../../../../../../shared/widgets/button/custom_button_label.dart';
import '../../../../../../../shared/widgets/custom_dialog.dart';
import '../../../../../../../shared/widgets/custom_text_field.dart';
import '../../../../cubit/auth_body/auth_body_cubit.dart';
import '../../../../cubit/wallet/wallet_cubit.dart';
import '../decription_text.dart';
import '../label_text.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.screenHeight * 0.25,
        ),
        LabelText(
          text: "Login Wallet",
        ),
        SizedBox(
          height: 6,
        ),
        DescriptionText(text: "Masukan password wallet anda sebelumnya"),
        SizedBox(
          height: 22,
        ),
        CustomTextField(
          controller: passwordController,
          hintText: "Masukan password",
          onEditingComplete: _onLoading,
          textInputAction: TextInputAction.done,
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
                context.read<AuthBodyCubit>().emit(AuthBodyImportWallet()),
            child: Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "Masuk dengan akun lain? ",
                  ),
                  TextSpan(
                      text: "import wallet",
                      style: CustomTextStyle.green4TextStyle),
                ],
              ),
            ),
          ),
        ),
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
