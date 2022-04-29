import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../core/models/return_value_model.dart';
import '../../../../../../../core/utils/preferences_info.dart';
import '../../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../../core/utils/secure_storage_info.dart';
import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../service_locator.dart';
import '../../../../../../../shared/config/asset_path_config.dart';
import '../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../shared/config/size_config.dart';
import '../../../../../../../shared/widgets/button/custom_button_label.dart';
import '../../../../../../../shared/widgets/custom_dialog.dart';
import '../../../../../../../shared/widgets/custom_text_field.dart';
import '../../../../../../../shared/widgets/show_svg/show_svg_asset.dart';
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
    return WillPopScope(
      onWillPop: () async {
        context.read<AuthBodyCubit>().emit(AuthBodyImportWallet());

        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: GestureDetector(
            onTap: () => Utils.hideKeyboard(context),
            child: ListView(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                CustomBackButton(
                  onTap: () => context
                      .read<AuthBodyCubit>()
                      .emit(AuthBodyImportWallet()),
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
                      text:
                          "Remember your password. It cannot be changed later.",
                    ),
                  ],
                ),
                SizedBox(
                  height: 22,
                ),
                CustomTextField(
                  controller: passwordController,
                  hintText: "Enter your password",
                  onEditingComplete: _checkLastWallet,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButtonLabel(
                  label: "Create Wallet",
                  onTap: _checkLastWallet,
                ),
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
                            style: CustomTextStyle.green4TextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _checkLastWallet() {
    // Close keyboard
    Utils.hideKeyboard(context);
    // Check passwordController.text != ""
    if (passwordController.text.trim() != "" &&
        passwordController.text.length >= 6) {
      // Check last wallet is exist
      if (sl<PreferencesInfo>().wallet != null) {
        CustomDialog.alertDialogConfirmation(
            context: context,
            buttonOkLabel: "Save Wallet",
            dismissable: false,
            onConfirmation: () {
              // Save Last Wallet file
              // TODO: Save last wallet to local phone
              // Create New Wallet
              _createWallet();
            },
            onCancel: () {
              // Close dialog
              ScreenNavigator.closeScreen(context);
              // Show toast
              CustomDialog.showToast(
                message: "You must save your last wallet first",
                context: context,
                backgroundColor: UniversalColor.red,
              );
            }).show(context);
      } else {
        _createWallet();
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

  void _createWallet() async {
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
      // Save Password to secureStorage
      sl<SecureStorageInfo>().setPasswordWallet(passwordController.text);
      // Create pin
      context.read<AuthBodyCubit>().emit(AuthBodyCreatePin());
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
