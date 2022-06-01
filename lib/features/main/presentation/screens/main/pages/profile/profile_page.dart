import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../../core/models/return_value_model.dart';
import '../../../../../../../core/utils/preferences_info.dart';
import '../../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../../service_locator.dart';
import '../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../shared/config/size_config.dart';
import '../../../../../../../shared/extension/string_parsing.dart';
import '../../../../../../../shared/widgets/button/custom_button_label.dart';
import '../../../../../../../shared/widgets/custom_dialog.dart';
import '../../../../../../../shared/widgets/show_svg/show_avatar_svg_network.dart';
import '../../../../../../../shared/widgets/widget_with_default_horizontal_padding.dart';
import '../../../../../../auth/presentation/cubit/save_wallet/save_wallet_cubit.dart';
import '../../../../../../auth/presentation/cubit/wallet/wallet_cubit.dart';
import '../../../../../../auth/presentation/screens/splash/splash_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: WidgetWithDefaultHorizontalPadding(
        child: SizedBox(
          width: SizeConfig.screenWidth,
          child: Column(
            children: [
              BlocBuilder<WalletCubit, WalletState>(
                builder: (context, state) {
                  if (state is WalletLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        ShowAvatarSvgNetwork(
                          address: state.wallet.privateKey.address.toString(),
                          height: 150,
                          width: 150,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          state.wallet.privateKey.address
                              .toString()
                              .walletAddressSplit(),
                          style: CustomTextStyle.gray1TextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    );
                  }

                  return SizedBox();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButtonLabel(
                label: "Logout",
                backgroundColor: Colors.white,
                labelColor: UniversalColor.red,
                borderColor: UniversalColor.red,
                onTap: () => _onSaveWallet(context),
              ),
            ],
          ),
        ),
      ),
    );
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

    // Dismiss progressDialog
    progressDialog.dismiss();

    // Navigator to splashScreen
    ScreenNavigator.removeAllScreen(context, SplashScreen());
  }
}
