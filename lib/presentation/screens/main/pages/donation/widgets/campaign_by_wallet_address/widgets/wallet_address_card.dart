import 'package:flutter/material.dart';

import '../../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../../shared/extension/string_parsing.dart';
import '../../../../../../../../shared/widgets/show_image/show_image_local.dart';

class WalletAddressCard extends StatelessWidget {
  const WalletAddressCard({Key? key}) : super(key: key);

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
          "0x4994986400D969EeA1f90bE393A5F1B1b72a664A".walletAddressSplit(),
          style: CustomTextStyle.gray3TextStyle.copyWith(
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
