import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../core/models/return_value_model.dart';
import '../../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../../shared/config/asset_path_config.dart';
import '../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../shared/config/size_config.dart';
import '../../../../../../../shared/widgets/custom_dialog.dart';
import '../../../../../../../shared/widgets/show_svg/show_svg_asset.dart';
import '../../../../../../main/presentation/screens/main/main_screen.dart';
import '../../../../cubit/auth_body/auth_body_cubit.dart';
import '../../../../cubit/wallet/wallet_cubit.dart';
import '../label_text.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  List<String?> pinVerification = [null, null, null, null, null, null];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.01,
                ),
                const LabelText(
                  text: "Pin Verification",
                ),
                const SizedBox(
                  height: 20,
                ),
                ShowSvgAsset(
                  assetUrl: AssetPathConfig.lockPath,
                  height: 130,
                ),
                const SizedBox(
                  height: 30,
                ),
                const LabelText(
                  text: "Enter Your Pin",
                ),
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.defaultMargin * 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pinVerification
                    .asMap()
                    .map(
                      (key, value) => MapEntry(
                        key,
                        Container(
                          height: 10,
                          width: 10,
                          margin: EdgeInsets.only(
                            left: (key == 0) ? 0 : 20,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (value != null)
                                ? UniversalColor.green4
                                : Colors.transparent,
                            border: Border.all(
                              color: (value != null)
                                  ? Colors.transparent
                                  : UniversalColor.gray3,
                            ),
                          ),
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ),
            ),
            Spacer(),
            NumericKeyboard(
              onKeyboardTap: _onKeyboardTap,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textColor: UniversalColor.gray1,
              rightIcon: Icon(
                Icons.backspace_outlined,
                color: UniversalColor.gray1,
              ),
              leftIcon: Icon(
                Icons.fingerprint,
                color: UniversalColor.gray1,
              ),
              rightButtonFn: _onKeyboardBackspaceTap,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 22),
              child: GestureDetector(
                onTap: () =>
                    context.read<AuthBodyCubit>().emit(AuthBodyImportWallet()),
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
            Spacer(),
          ],
        ),
      ),
    );
  }

  void _onKeyboardTap(String value) {
    int index = pinVerification.indexOf(null);
    if (index != -1) {
      setState(() {
        pinVerification[index] = value;
      });
      if (!pinVerification.contains(null)) {
        _onLoading();
      }
    }
  }

  void _onKeyboardBackspaceTap() {
    if (pinVerification.first != null) {
      int index = pinVerification.indexOf(null);
      if (index == -1) {
        pinVerification.last = null;
      } else {
        pinVerification[index - 1] = null;
      }
      setState(() {});
    }
  }

  void _onSigninWithFingerprint () {
    // TODO: Signin with fingerprint
  }

  void _onLoading() async {
    CustomProgressDialog progressDialog =
        CustomDialog.showCustomProgressDialog(context: context);
    // Show progressDialog
    progressDialog.show();

    // Save pins
    String pins = "";

    // Get pin from pinVerification
    for (String? pin in pinVerification) {
      pins += pin ?? "";
    }

    // Process login wallet
    final ReturnValueModel<Wallet> result =
        await context.read<WalletCubit>().login(password: pins);

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
      // Set pinVerification to null
      setState(() {
        pinVerification = [null, null, null, null, null, null];
      });
    }
  }
}
