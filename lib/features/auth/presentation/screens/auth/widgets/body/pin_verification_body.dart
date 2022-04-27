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
import '../../../../cubit/biometric_auth/biometric_auth_cubit.dart';
import '../../../../cubit/wallet/wallet_cubit.dart';
import '../label_text.dart';

class PinVerificationBody extends StatefulWidget {
  const PinVerificationBody({Key? key}) : super(key: key);

  @override
  _PinVerificationBodyState createState() => _PinVerificationBodyState();
}

class _PinVerificationBodyState extends State<PinVerificationBody> {
  List<String?> pins = [null, null, null, null, null, null];

  @override
  void initState() {
    super.initState();
    biometricAuth();
  }

  void biometricAuth() async {
    await context.read<BiometricAuthCubit>().checkAuth().then((value) => _showFingerprintAlertDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              children: pins
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
            leftButtonFn: _showFingerprintAlertDialog,
            rightButtonFn: _onKeyboardBackspaceTap,
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
    );
  }

  void _onKeyboardTap(String value) {
    int index = pins.indexOf(null);
    if (index != -1) {
      setState(() {
        pins[index] = value;
      });
      if (!pins.contains(null)) {
        _onLoading();
      }
    }
  }

  void _onKeyboardBackspaceTap() {
    if (pins.first != null) {
      int index = pins.indexOf(null);
      if (index == -1) {
        pins.last = null;
      } else {
        pins[index - 1] = null;
      }
      setState(() {});
    }
  }

  void _showFingerprintAlertDialog() {
    Future.delayed(Duration.zero, () {
      final BiometricAuthState biometricAuthState =
          context.read<BiometricAuthCubit>().state;
      if (biometricAuthState is BiometricAuthSuccess) {
        NAlertDialog(
          title: Center(
            child: Text(
              "Crowdfunding Biometric Login",
              style: CustomTextStyle.gray1TextStyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Signin using your biomteric credential",
                style: CustomTextStyle.gray1TextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
              Icon(
                Icons.fingerprint,
                size: 40,
                color: UniversalColor.gray2,
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () => ScreenNavigator.closeScreen(context),
              child: Center(
                child: Text(
                  "Use PIN",
                  style: CustomTextStyle.blue2TextStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ).show(context);
      } else if (biometricAuthState is BiometricAuthNotAvailable) {
        CustomDialog.showToast(
          message: "Fingerprint auth not found",
          context: context,
          backgroundColor: UniversalColor.red,
        );
      }
    });
  }

  void _onSigninWithFingerprint() {
    // TODO: Signin with fingerprint
  }

  void _onLoading() async {
    CustomProgressDialog progressDialog =
        CustomDialog.showCustomProgressDialog(context: context);
    // Show progressDialog
    progressDialog.show();

    // Save pins
    String newPins = "";

    // Get pin from PinVerificationBody
    for (String? pin in pins) {
      newPins += pin ?? "";
    }

    // Process login wallet
    final ReturnValueModel<Wallet> result =
        await context.read<WalletCubit>().login(password: newPins);

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
      // Set PinVerificationBody to null
      setState(() {
        pins = [null, null, null, null, null, null];
      });
    }
  }
}
