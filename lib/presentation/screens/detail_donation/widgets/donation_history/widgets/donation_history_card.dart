import 'package:flutter/material.dart';

import '../../../../../../core/config/custom_color.dart';
import '../../../../../../core/config/custom_text_style.dart';
import '../../../../../../core/config/size_config.dart';
import '../../../../../../core/extension/string_parsing.dart';
import '../../../../../widgets/show_image/show_image_local.dart';

class DonationHistoryCard extends StatelessWidget {
  const DonationHistoryCard({
    Key? key,
  }) : super(key: key);

  // TODO => add History Donation Model

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.defaultMargin - 5,
        horizontal: SizeConfig.defaultMargin - 8,
      ),
      decoration: BoxDecoration(
          color: UniversalColor.gray6, borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          // TODO => Change image to generated random image by wallet address
          ShowImageLocal(
            imageUrl: "",
            borderRadius: BorderRadius.circular(100),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TODO => Change to real address
                Text(
                  "0x4994986400D969EeA1f90bE393A5F1B1b72a664A"
                      .walletAddressSplit(),
                  style: CustomTextStyle.green4TextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Donate for ",
                        style: CustomTextStyle.gray2TextStyle.copyWith(
                          fontSize: 13,
                        ),
                      ),
                      // TODO => Change to real donation amount
                      TextSpan(
                        text: " 0.00001 ETH",
                        style: CustomTextStyle.gray2TextStyle.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
