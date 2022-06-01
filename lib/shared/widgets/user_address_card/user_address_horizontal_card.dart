import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

import '../../../shared/config/custom_text_style.dart';
import '../../../shared/extension/string_parsing.dart';
import '../show_svg/show_avatar_svg_network.dart';

class UserAddressHorizontalCard extends StatelessWidget {
  const UserAddressHorizontalCard({
    Key? key,
    required this.address,
  }) : super(key: key);

  final EthereumAddress? address;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShowAvatarSvgNetwork(
          address: address.toString(),
          height: 50,
          width: 50,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            "$address".walletAddressSplit(),
            style: CustomTextStyle.gray3TextStyle.copyWith(
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
