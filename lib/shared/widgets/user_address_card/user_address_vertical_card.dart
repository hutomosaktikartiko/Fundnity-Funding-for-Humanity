import 'package:flutter/material.dart';

import '../../../shared/config/custom_text_style.dart';
import '../../../shared/extension/string_parsing.dart';
import '../show_svg/show_avatar_svg_network.dart';

class UserAddressVerticalCard extends StatelessWidget {
  const UserAddressVerticalCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShowAvatarSvgNetwork(
          address: "0x4994986400D969EeA1f90bE393A5F1B1b72a664A",
          height: 50,
          width: 50,
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
