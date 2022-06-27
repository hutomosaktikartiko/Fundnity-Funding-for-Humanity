import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../../../core/models/return_value_model.dart';
import '../../../../../../../../core/utils/preferences_info.dart';
import '../../../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../../../service_locator.dart';
import '../../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../../shared/widgets/button/custom_button_label.dart';
import '../../../../../../../../shared/widgets/custom_dialog.dart';
import '../../../../../../../auth/presentation/cubit/auth_body/auth_body_cubit.dart';
import '../../../../../../../auth/presentation/cubit/onesignal/one_signal_cubit.dart';
import '../../../../../../../auth/presentation/cubit/save_wallet/save_wallet_cubit.dart';
import '../../../../../../../auth/presentation/cubit/selected_onboarding/selected_onboarding_cubit.dart';
import '../../../../../../../auth/presentation/cubit/wallet/wallet_cubit.dart';
import '../../../../../../../auth/presentation/screens/splash/splash_screen.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButtonLabel(
      label: "Logout",
      backgroundColor: Colors.white,
      labelColor: UniversalColor.red,
      borderColor: UniversalColor.red,
      onTap: () => _onLogoutTap(context),
    );
  }

  void _onLogoutTap(BuildContext context) {
    if (context.read<WalletCubit>().state is WalletLoaded) {
      _onSaveWallet(context);
    }
  }

  void _onSaveWallet(BuildContext context) {
    CustomDialog.alertDialogConfirmation(
      context: context,
      label:
          "Your last waller file is still exist, you must save it before create new wallet",
      buttonOkLabel: "Save Wallet",
      dismissable: false,
      onConfirmation: () async {
        // Save Last Wallet file
        CustomProgressDialog progressDialog =
            CustomDialog.showCustomProgressDialog(context: context);

        //Show progressDialog
        progressDialog.show();

        // Save wallet
        final ReturnValueModel result = await context
            .read<SaveWalletCubit>()
            .saveWallet(wallet: sl<PreferencesInfo>().wallet);

        //Dismiss progressDialog
        progressDialog.dismiss();

        // Close dialog
        ScreenNavigator.closeScreen(context);

        if (result.isSuccess) {
          // Success save wallet
          // Show toast
          CustomDialog.showToast(
            message: result.message,
            context: context,
            backgroundColor: UniversalColor.green4,
          );
          // Logout
          _onLogout(context);
        } else {
          // Failed save wallet
          // Show toast
          CustomDialog.showToast(
            message: result.message,
            context: context,
            backgroundColor: UniversalColor.red,
          );
        }
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
      },
    ).show(context);
  }

  void _onLogout(BuildContext context) async {
    ProgressDialog progressDialog = CustomDialog.showProgressDialog(
      context: context,
      message: "Logout...",
    );
    // Show progressDialog
    progressDialog.show();

    // Delete all secure storage data
    await sl<FlutterSecureStorage>().deleteAll();

    // TODO: Migrate sharedPref to secureStorage
    // Delete all shared preferences data
    await sl<SharedPreferences>().clear();

    // Remove external userId OneSignal
    await context.read<OneSignalCubit>().removeExternalUserId();

    // Set AuthBodyCubit to initial state
    context.read<AuthBodyCubit>().initialState();

    // Set SelectedOnboardingCubit to initial state
    context.read<SelectedOnboardingCubit>().initialState();

    // Dismiss progressDialog
    progressDialog.dismiss();

    // Navigator to splashScreen
    ScreenNavigator.removeAllScreen(context, SplashScreen());
  }
}
