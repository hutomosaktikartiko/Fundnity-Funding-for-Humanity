import 'package:flutter/material.dart';

import '../../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../../core/utils/secure_storage_info.dart';
import '../../../../../../../service_locator.dart';
import '../../../../../../../shared/config/asset_path_config.dart';
import '../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../shared/config/size_config.dart';
import '../../../../../../../shared/widgets/custom_dialog.dart';
import '../../../../../../../shared/widgets/custom_numeric_keyboard.dart';
import '../../../../../../../shared/widgets/show_svg/show_svg_asset.dart';
import '../../../../../../main/presentation/screens/main/main_screen.dart';
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

  void _onLoading() async {
    CustomDialog.alertDialogConfirmation(
      context: context,
      label:
          "This pin is used for login in this app, are you sure to use this pin?",
      buttonOkLabel: "Save PIN",
      dismissable: false,
      onConfirmation: () {
        // Save pins
        String newPins = "";

        // Get pin from PinVerificationBody
        for (String? pin in pins) {
          newPins += pin ?? "";
        }
        sl<SecureStorageInfo>().setPinVerification(newPins);

        // Navigate to HomeScreen
        ScreenNavigator.removeAllScreen(context, MainScreen());
      },
      onCancel: () {
        // Clear pins
        setState(() {
          pins = [null, null, null, null, null, null];
        });
        // Close dialog
        ScreenNavigator.closeScreen(context);
      },
    ).show(context);
  }
}
