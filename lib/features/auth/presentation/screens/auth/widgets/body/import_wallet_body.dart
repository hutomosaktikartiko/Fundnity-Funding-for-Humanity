import 'dart:io';

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

class ImportWalletBody extends StatefulWidget {
  const ImportWalletBody({Key? key}) : super(key: key);

  @override
  _ImportWalletBodyState createState() => _ImportWalletBodyState();
}

class _ImportWalletBodyState extends State<ImportWalletBody> {
  TextEditingController passwordController = TextEditingController();
  File? walletFile;

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
                    text: "Import Wallet",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ShowSvgAsset(
                    assetUrl: AssetPathConfig.transferfilePath,
                    height: 130,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const DescriptionText(
                    text: "Your wallet must be in .json or UTC format",
                  ),
                ],
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                children: [
                  CustomButtonLabel(
                    label: walletFile?.path ?? "Select wallet",
                    backgroundColor: UniversalColor.gray5,
                    width: SizeConfig.screenWidth * 0.27,
                    fontSize: 12,
                    onTap: _selectFile,
                    paddingVertical: 16,
                    borderColor: UniversalColor.gray5,
                    labelColor: UniversalColor.gray3,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: passwordController,
                      hintText: "Enter your password",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              SizedBox(
                height: 10,
              ),
              CustomButtonLabel(label: "Login", onTap: _onLoading),
              SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () =>
                    context.read<AuthBodyCubit>().emit(AuthBodyCreateWallet()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Don't have a wallet? ",
                          ),
                          TextSpan(
                            text: "create wallet here",
                            style: CustomTextStyle.green4TextStyle,
                          ),
                        ],
                      ),
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
      ProgressDialog progressDialog = CustomDialog.showProgressDialog(
      context: context,
      message: "Checking your wallet",
    );
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
    } else {
      // Show toast
      CustomDialog.showToast(
        message: "Wallet file and password could not be empty",
        context: context,
        backgroundColor: UniversalColor.red,
      );
    }
  }
}