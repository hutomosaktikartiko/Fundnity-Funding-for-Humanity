import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../core/models/return_value_model.dart';
import '../../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../../core/utils/secure_storage_info.dart';
import '../../../../../../../service_locator.dart';
import '../../../../../../../shared/config/asset_path_config.dart';
import '../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../shared/config/secure_storage_key.dart';
import '../../../../../../../shared/config/size_config.dart';
import '../../../../../../../shared/widgets/custom_dialog.dart';
import '../../../../../../../shared/widgets/custom_numeric_keyboard.dart';
import '../../../../../../../shared/widgets/show_svg/show_svg_asset.dart';
import '../../../../../../main/presentation/screens/main/main_screen.dart';
import '../../../../cubit/wallet/wallet_cubit.dart';
import '../decription_text.dart';
import '../label_text.dart';

class CreatePinBody extends StatefulWidget {
  const CreatePinBody({Key? key}) : super(key: key);

  @override
  State<CreatePinBody> createState() => _CreatePinBodyState();
}

class _CreatePinBodyState extends State<CreatePinBody> {
  List<String?> pins = [null, null, null, null, null, null];

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
                  text: "Create Pin Verification",
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
                const DescriptionText(
                  text: "Please enter your pin",
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
                          child: (value == null)
                              ? Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: UniversalColor.gray3,
                                    ),
                                  ),
                                )
                              : Text(value, style: TextStyle(fontSize: 10)),
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ),
            ),
            Spacer(),
            CustomNumericKeyboard(
              onKeyboardTap: _onKeyboardTap,
              onRightButtonTap: _onKeyboardBackspaceTap,
            ),
            Spacer(),
          ],
        ),
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
        _onCreatePin();
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

  void _onCreatePin() async {
    CustomDialog.alertDialogConfirmation(
      context: context,
      label:
          "This pin is used for login in this app, are you sure to use this pin?",
      buttonOkLabel: "Save PIN",
      dismissable: false,
      onConfirmation: () {
        // Save pins
        String newPins = "";

        // Set list pins to String newPIn
        for (String? pin in pins) {
          newPins += pin ?? "";
        }

        // Save pin to local
        sl<SecureStorageInfo>().setValue(key: SecureStorageKey.pin,value: newPins);

        // Login to wallet
        _onLoading();
      },
      onCancel: () {
        // Clear pins
        setState(() {
          pins.last = null;
        });
        // Close dialog
        ScreenNavigator.closeScreen(context);
      },
    ).show(context);
  }

  void _onLoading() async {
    ProgressDialog progressDialog = CustomDialog.showProgressDialog(
      context: context,
      message: "Login to your wallet",
    );
    // Show progressDialog
    progressDialog.show();

    // Process login wallet
    final ReturnValueModel<Wallet> result = await context
        .read<WalletCubit>()
        .login(
            password: await sl<SecureStorageInfo>().getValue(key: SecureStorageKey.password) ?? "");

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
