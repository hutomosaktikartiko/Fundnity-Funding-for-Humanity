import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/preferences_info.dart';
import '../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../core/utils/secure_storage_info.dart';
import '../../../../../../service_locator.dart';
import '../../../../../../shared/config/secure_storage_key.dart';
import '../../../../../../shared/widgets/custom_dialog.dart';
import '../../../../../main/presentation/cubit/crowdfunding_deployed_contract/crowdfunding_deployed_contract_cubit.dart';
import '../../../cubit/auth_body/auth_body_cubit.dart';
import '../../auth/auth_screen.dart';
import '../../onboarding/onboarding_screen.dart';
import '../widgets/body.dart';
import 'connection_error.dart';

class ConnectionSuccess extends StatelessWidget {
  const ConnectionSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return checkStatus(context: context);
  }

  Widget checkStatus({required BuildContext context}) {
    return BlocBuilder<CrowdfundingDeployedContractCubit,
        CrowdfundingDeployedContractState>(
      builder: (context, state) {
        if (state is CrowdfundingDeployedContractLoaded) {
          _checkData(context);

          return Body(
            child: CustomDialog.showCircularProgressIndicator(),
          );
        } else if (state is CrowdfundingDeployedContractLoadingFailure) {
          return ConnectionError();
        } else {
          return Body(
            child: CustomDialog.showCircularProgressIndicator(),
          );
        }
      },
    );
  }

  void _checkData(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback(
      (_) async {
        // Get update status
        // UpdateInfo updateInfo = sl<UpdateInfo>();
        // Check app update status
        // if [true] app must be update
        // else [false] app updated
        // FIXME: Error check app version from playstore
        // Issued https://github.com/timtraversy/new_version/issues/107
        // if ((await updateInfo.versionStatus.then((value) => value?.canUpdate)) == true) {
        //   // Get version status
        //   VersionStatus? versionStatus = await updateInfo.versionStatus;
        //   // Show update dialog
        //   if (versionStatus != null) {
        //     sl<NewVersion>().showUpdateDialog(
        //       context: context,
        //       versionStatus: versionStatus,
        //       allowDismissal: false,
        //     );
        //   }
        // } else {
        // Check is new user
        if (sl<PreferencesInfo>().isNewUser == null) {
          // New user
          // Show onboarding
          ScreenNavigator.replaceScreen(context, OnBoardingScreen());
        } else {
          // Check user local wallet is exist
          if (sl<PreferencesInfo>().wallet != null) {
            // User local wallet is exist
            // Check user local pin is exist
            if (await sl<SecureStorageInfo>()
                    .getValue(key: SecureStorageKey.pin) ==
                null) {
              // pin is notexist
              // Set auth body to create pin
              context.read<AuthBodyCubit>().emit(AuthBodyCreatePin());
            } else {
              // User local wallet is exist
              // Set auth body to login
              context.read<AuthBodyCubit>().emit(AuthBodyPinVerification());
            }
          }
          // User must be login back to wallet
          // Navigator to authScreen
          ScreenNavigator.removeAllScreen(context, AuthScreen());
        }
        // }
      },
    );
  }
}
