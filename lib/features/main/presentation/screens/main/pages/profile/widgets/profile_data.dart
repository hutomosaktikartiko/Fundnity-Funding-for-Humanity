import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../../shared/extension/string_parsing.dart';
import '../../../../../../../../shared/widgets/show_svg/show_avatar_svg_network.dart';
import '../../../../../../../auth/presentation/cubit/wallet/wallet_cubit.dart';

class ProfileData extends StatelessWidget {
  const ProfileData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
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
                state.wallet.privateKey.address.toString().walletAddressSplit(),
                style: CustomTextStyle.gray1TextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          );
        }

        // Not Login
        // TODO: Not login UI
        return SizedBox.shrink();
      },
    );
  }
}
