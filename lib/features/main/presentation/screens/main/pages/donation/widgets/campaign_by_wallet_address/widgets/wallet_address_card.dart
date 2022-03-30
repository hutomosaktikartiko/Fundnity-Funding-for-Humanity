import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../../../../shared/extension/string_parsing.dart';
import '../../../../../../../../../../shared/widgets/show_image/show_image_local.dart';

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
        // TODO => Change image to generated random image by wallet address
        ShowImageLocal(
          imageUrl: "",
          borderRadius: BorderRadius.circular(100),
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
