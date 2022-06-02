import 'package:flutter/material.dart';

import '../../../../../../../../shared/config/asset_path_config.dart';
import '../../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../../shared/extension/big_int_parsing.dart';
import '../../../../../../../../shared/extension/int_parsing.dart';
import '../../../../../../../../shared/widgets/custom_box_shadow.dart';
import '../../../../../../../../shared/widgets/show_image/show_image_local.dart';
import '../../../../../../data/models/history_model.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    Key? key,
    required this.history,
  }) : super(key: key);

  final HistoryModel? history;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          CustomBoxShadow.defaultBoxShadow(),
        ],
      ),
      child: Row(
        children: [
          ShowImageLocal(
            imageUrl: iconPath(),
            height: 40,
            width: 40,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title(),
                      style: CustomTextStyle.gray2TextStyle.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      history?.campaignTitle ?? "_",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyle.gray2TextStyle.copyWith(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${history?.timestamp.intDateToString() ?? 0}",
                      style: CustomTextStyle.gray2TextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String iconPath() {
    if (history?.category == 1) {
      return AssetPathConfig.iconDonation;
    } else {
      return AssetPathConfig.iconCreateCampaign;
    }
  }

  String title() {
    if (history?.category == 1) {
      return 'You donation ${BigInt.from(int.parse(history?.amount ?? "0")).weiEtherToDoubleEther()} ETH';
    } else {
      return 'You create campaign';
    }
  }
}
