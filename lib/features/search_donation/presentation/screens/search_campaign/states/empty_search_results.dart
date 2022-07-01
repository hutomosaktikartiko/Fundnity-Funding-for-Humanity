import 'package:crowdfunding/shared/config/custom_color.dart';
import 'package:flutter/material.dart';

import '../../../../../../shared/config/asset_path_config.dart';
import '../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../shared/config/size_config.dart';
import '../../../../../../shared/widgets/campaign_card/vertical_campaign_card.dart';
import '../../../../../../shared/widgets/show_svg/show_svg_asset.dart';
import '../../../../../main/data/models/campaign_model.dart';

class EmptySearchResults extends StatelessWidget {
  const EmptySearchResults({
    Key? key,
    required this.campaigns,
    required this.isSearching,
  }) : super(key: key);

  final List<CampaignModel> campaigns;
  final bool isSearching;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildEmptyResults(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.defaultMargin,
            vertical: 10,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Campaigns for you",
                    style: CustomTextStyle.blackTextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ...((campaigns.length > 5) ? campaigns.sublist(0, 5) : campaigns)
                  .asMap()
                  .map(
                    (key, campaign) => MapEntry(
                      key,
                      Padding(
                        padding: EdgeInsets.only(
                          top: (key == 0) ? 10 : 0,
                          bottom: 10,
                        ),
                        child: VerticalCampaignCard(
                          campaign: campaign,
                        ),
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildEmptyResults() {
    if (isSearching) {
      // Show empty result info
      return Column(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: SizeConfig.defaultMargin,
            ),
            color: Colors.white,
            child: Column(
              children: [
                ShowSvgAsset(
                  assetUrl: AssetPathConfig.emptyPath,
                  height: 100,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Campaign not found",
                  style: CustomTextStyle.gray1TextStyle
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Please check your search keywords and try again",
                  style: CustomTextStyle.gray3TextStyle.copyWith(),
                )
              ],
            ),
          ),
          Container(
            color: BackgroundColor.bgGray,
            height: 10,
          ),
        ],
      );
    }

    return SizedBox.shrink();
  }
}
