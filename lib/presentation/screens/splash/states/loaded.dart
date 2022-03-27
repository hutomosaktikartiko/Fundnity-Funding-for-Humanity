import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_version/new_version.dart';

import '../../../../core/preferences/preferences_info.dart';
import '../../../../core/update/update_info.dart';
import '../../../../core/utils/screen_navigator.dart';
import '../../../../service_locator.dart';
import '../../../cubit/cubits.dart';
import '../../../widgets/custom_dialog.dart';
import '../../auth/auth_screen.dart';
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
        if ((await updateInfo.versionStatus
                .then((value) => value?.canUpdate)) ==
            false) {
          // Get version status
          VersionStatus? versionStatus = await updateInfo.versionStatus;
          // Show update dialog
          sl<NewVersion>().showUpdateDialog(
            context: context,
            versionStatus: versionStatus!,
            allowDismissal: false,
          );
        } else {
          // Check is new user
          // DEV => Should check == [null]
          if (sl<PreferencesInfo>().isNewUser == null) {
            // New user
            // Show onboarding
            ScreenNavigator.replaceScreen(context, OnBoardingScreen());
          } else {
            // Check user local wallet is exist
            if (sl<PreferencesInfo>().wallet != null) {
              // User local wallet is exist
              // Set auth body to login
              context.read<AuthBodyCubit>().emit(AuthBodyLogin());
            }
            // User must be login back to wallet
            // Navigator to authScreen
            ScreenNavigator.removeAllScreen(context, AuthScreen());
          }
        }
      },
    );
    return Body(
      child: CustomDialog.showCircularProgressIndicator(),
    );
  }
}
