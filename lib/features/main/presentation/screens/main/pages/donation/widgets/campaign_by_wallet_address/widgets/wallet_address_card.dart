import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../../../../shared/extension/string_parsing.dart';
import '../../../../../../../../../../shared/widgets/show_svg/show_avatar_svg_network.dart';

class WalletAddressCard extends StatelessWidget {
  const WalletAddressCard({
    Key? key,
    required this.address,
  }) : super(key: key);

  final EthereumAddress? address;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShowAvatarSvgNetwork(
          address: address.toString(),
          height: 50,
          width: 50,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "$address".walletAddressSplit(),
          style: CustomTextStyle.gray3TextStyle.copyWith(
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
