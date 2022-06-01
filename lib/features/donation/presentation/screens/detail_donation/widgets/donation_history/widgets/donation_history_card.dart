import 'package:flutter/material.dart';

import '../../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../../shared/config/size_config.dart';
import '../../../../../../../../shared/extension/big_int_parsing.dart';
import '../../../../../../../../shared/extension/string_parsing.dart';
import '../../../../../../../../shared/widgets/show_svg/show_avatar_svg_network.dart';
import '../../../../../../data/models/contributor_model.dart';

class DonationHistoryCard extends StatelessWidget {
  const DonationHistoryCard({
    Key? key,
    required this.contributor,
  }) : super(key: key);

  final ContributorModel? contributor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.defaultMargin - 5,
        horizontal: SizeConfig.defaultMargin - 8,
      ),
      decoration: BoxDecoration(
        color: UniversalColor.gray6,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          ShowAvatarSvgNetwork(
          address: contributor?.contributor.toString() ?? "-",
          height: 50,
          width: 50,
        ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${contributor?.contributor}".walletAddressSplit(),
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
                      TextSpan(
                        text: " ${contributor?.amount.etherInWeiToEther() ?? 0} ETH",
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
