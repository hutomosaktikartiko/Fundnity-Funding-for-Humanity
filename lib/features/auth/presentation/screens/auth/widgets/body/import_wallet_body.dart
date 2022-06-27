import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../core/models/return_value_model.dart';
import '../../../../../../../core/utils/preferences_info.dart';
import '../../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../service_locator.dart';
import '../../../../../../../shared/config/asset_path_config.dart';
import '../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../shared/config/size_config.dart';
import '../../../../../../../shared/widgets/button/custom_button_label.dart';
import '../../../../../../../shared/widgets/custom_dialog.dart';
import '../../../../../../../shared/widgets/custom_text_field.dart';
import '../../../../../../../shared/widgets/obsecure_password_icon.dart';
import '../../../../../../../shared/widgets/show_svg/show_svg_asset.dart';
import '../../../../../../main/presentation/screens/main/main_screen.dart';
import '../../../../cubit/auth_body/auth_body_cubit.dart';
import '../../../../cubit/obsecure_password/obsecure_password_cubit.dart';
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
    return WillPopScope(
      onWillPop: () async {
        if (sl<PreferencesInfo>().wallet != null) {
          context.read<AuthBodyCubit>().emit(AuthBodyPinVerification());
        }

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
                  height: SizeConfig.screenHeight * 0.01,
                ),
                (sl<PreferencesInfo>().wallet != null)
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.04),
                        child: CustomBackButton(
                          onTap: () => context
                              .read<AuthBodyCubit>()
                              .emit(AuthBodyPinVerification()),
                        ),
                      )
                    : SizedBox.shrink(),
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
                    BlocBuilder<ObsecurePasswordCubit, ObsecurePasswordState>(
                      builder: (context, state) {
                        return Expanded(
                          child: CustomTextField(
                            obscureText: state.isObsecure,
                            controller: passwordController,
                            hintText: "Enter your password",
                            suffixWidget: GestureDetector(
                              onTap: _obsecurePasswordTap,
                              child: ObscurePasswordIcon(
                                isObscure: state.isObsecure,
                              ),
                            ),
                            onEditingComplete: _onLoading,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButtonLabel(
                  label: "Import Wallet",
                  onTap: _onLoading,
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomButtonLabel(
                  label: "Get Started",
                  backgroundColor: Colors.white,
                  labelColor: UniversalColor.green4,
                  onTap: _onGetStartedTap,
                ),
                SizedBox(
                  height: 22,
                ),
                GestureDetector(
                  onTap: _onCreateWalletTap,
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
      ),
    );
  }

  void _obsecurePasswordTap() {
    context.read<ObsecurePasswordCubit>().changeObsecureState();
  }

  void _onGetStartedTap() {
    ScreenNavigator.replaceScreen(context, MainScreen());
  }

  void _onCreateWalletTap() {
    context.read<AuthBodyCubit>().emit(AuthBodyCreateWallet());
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
      ReturnValueModel<Wallet>? result;
      await Future.delayed(
        Duration(seconds: 2),
        () async {
          result = await context.read<WalletCubit>().importWallet(
              file: walletFile!, password: passwordController.text);
        },
      );

      // Dimiss progressDialog
      progressDialog.dismiss();

      // Check result
      if (result?.isSuccess == true) {
        // Import Wallet Success
        // Create pin
        context.read<AuthBodyCubit>().emit(AuthBodyCreatePin());
      } else {
        // Import Wallet failed
        // Show toast
        CustomDialog.showToast(
          message: result?.message,
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
