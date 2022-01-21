import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:new_version/new_version.dart';

import '../../../../core/update/update_info.dart';
import '../../../../core/utils/preferences.dart';
import '../../../../core/utils/screen_navigator.dart';
import '../../../../data/models/return_value_model.dart';
import '../../../../injection_container.dart';
import '../../../widgets/custom_dialog.dart';
import '../../auth/auth_screen.dart';
import '../../main/main_screen.dart';
import '../../onboarding/onboarding_screen.dart';
import '../widgets/body.dart';

class Loaded extends StatelessWidget {
  const Loaded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return checkStatus(context: context);
  }

  Widget checkStatus({required BuildContext context}) {
    SchedulerBinding.instance?.addPostFrameCallback(
      (_) async {
        // Get update status
        UpdateInfo updateInfo = sl<UpdateInfo>();
        // Check app update status
        // if [true] app must be update
        // else [false] app updated
        // DEV -> Replace this condition to check with [true] value
        // if ((await updateInfo.versionStatus
        //         .then((value) => value?.canUpdate)) ==
        //     false) {
        //   // Get version status
        //   VersionStatus? versionStatus = await updateInfo.versionStatus;
        //   // Show update dialog
        //   sl<NewVersion>().showUpdateDialog(
        //     context: context,
        //     versionStatus: versionStatus!,
        //     allowDismissal: false,
        //   );
        // } else {
          // Check is new user
          // DEV => Should check == [null]
          if (sl<Preferences>().isNewUser == null) {
            // New user
            // Show onboarding
            ScreenNavigator.replaceScreen(context, OnBoardingScreen());
          } else {
            // Check user is loggin with local token
            if (sl<Preferences>().token != null) {
              // User token available
              // Get user profile
              ReturnValueModel<bool> result =
                  await Future.delayed(Duration(seconds: 1))
                      .then((value) => ReturnValueModel(value: true));
              if (result.value == true) {
                // Success get user profile
                // Waiting for the first data should be loaded
                // await Future.wait([
                // ]);
                ScreenNavigator.replaceScreen(context, MainScreen());
              } else {
                // User token expired or error when get profile
                ScreenNavigator.replaceScreen(context, AuthScreen());
                CustomDialog.showToast(
                  message: result.message,
                  context: context,
                );
              }
            } else {
              // User not logged in
              ScreenNavigator.replaceScreen(context, AuthScreen());
            }
          }
        }
      // },s
    );
    return Body(
      child: CustomDialog.showCircularProgressIndicator(),
    );
  }
}
