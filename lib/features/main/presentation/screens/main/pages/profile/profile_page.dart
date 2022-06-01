import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../shared/config/size_config.dart';
import '../../../../../../../shared/extension/string_parsing.dart';
import '../../../../../../../shared/widgets/button/custom_button_label.dart';
import '../../../../../../../shared/widgets/show_svg/show_avatar_svg_network.dart';
import '../../../../../../../shared/widgets/widget_with_default_horizontal_padding.dart';
import '../../../../../../auth/presentation/cubit/wallet/wallet_cubit.dart';

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
                onTap: ()  => _onLogout(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLogout(BuildContext context) {
    //TODO: Logout
  }
}
