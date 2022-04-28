import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../core/models/return_value_model.dart';
import '../../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../shared/config/asset_path_config.dart';
import '../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../shared/config/size_config.dart';
import '../../../../../../../shared/widgets/button/custom_button_label.dart';
import '../../../../../../../shared/widgets/custom_dialog.dart';
import '../../../../../../../shared/widgets/custom_text_field.dart';
import '../../../../../../../shared/widgets/show_svg/show_svg_asset.dart';
import '../../../../../../main/presentation/screens/main/main_screen.dart';
import '../../../../cubit/auth_body/auth_body_cubit.dart';
import '../../../../cubit/wallet/wallet_cubit.dart';
import '../custom_back_button.dart';
import '../decription_text.dart';
import '../label_text.dart';

class CreateWalletBody extends StatefulWidget {
  const CreateWalletBody({Key? key}) : super(key: key);

  @override
  _CreateWalletBodyState createState() => _CreateWalletBodyState();
}

class _CreateWalletBodyState extends State<CreateWalletBody> {
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => Utils.hideKeyboard(context),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.05,
              ),
              CustomBackButton(
                onTap: () => context
                    .read<AuthBodyCubit>()
                    .emit(AuthBodyPinVerification()),
              ),
              Column(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.01,
                  ),
                  const LabelText(
                    text: "Create New Wallet",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ShowSvgAsset(
                    assetUrl: AssetPathConfig.warningPath,
                    height: 130,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const DescriptionText(
                    text: "Remember your password. It cannot be changed later.",
                  ),
                ],
              ),
              SizedBox(
                height: 22,
              ),
              CustomTextField(
                controller: passwordController,
                hintText: "Enter your password",
              ),
              SizedBox(
                height: 10,
              ),
              CustomButtonLabel(label: "Create Wallet", onTap: _createWallet),
              SizedBox(
                height: 22,
              ),
              Center(
                child: GestureDetector(
                  onTap: () => context
                      .read<AuthBodyCubit>()
                      .emit(AuthBodyImportWallet()),
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Signin with another wallet? ",
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
          ),
        ),
      ),
    );
  }

  void _createWallet() async {
    // Check passwordController.text != ""
    if (passwordController.text.trim() != "") {
      ProgressDialog progressDialog = CustomDialog.showProgressDialog(
      context: context,
      message: "Creating your wallet",
    );
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
    } else {
      // Password empty
      // Show toast
      CustomDialog.showToast(
        message: "Password can't be empty",
        context: context,
        backgroundColor: UniversalColor.red,
      );
    }
  }
}
