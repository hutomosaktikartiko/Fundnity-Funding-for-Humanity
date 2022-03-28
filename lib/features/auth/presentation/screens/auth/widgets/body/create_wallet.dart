import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../core/models/return_value_model.dart';
import '../../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../shared/widgets/button/custom_button_label.dart';
import '../../../../../../../shared/widgets/custom_dialog.dart';
import '../../../../../../../shared/widgets/custom_text_field.dart';
import '../../../../../../main/presentation/screens/main/main_screen.dart';
import '../../../../cubit/auth_body/auth_body_cubit.dart';
import '../../../../cubit/wallet/wallet_cubit.dart';
import '../custom_back_button.dart';
import '../decription_text.dart';
import '../label_text.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomBackButton(
          onTap: () =>
              context.read<AuthBodyCubit>().emit(AuthBodyImportWallet()),
        ),
        LabelText(
          text: "Buat Wallet",
        ),
        SizedBox(
          height: 6,
        ),
        DescriptionText(
            text: "Password akan digunakan untuk login selanjutnya"),
        SizedBox(
          height: 22,
        ),
        CustomTextField(
          controller: passwordController,
          hintText: "Masukan password",
        ),
        SizedBox(
          height: 10,
        ),
        CustomButtonLabel(label: "Buat Wallet", onTap: _createWallet),
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
