import 'package:flutter/material.dart';

import '../../../../../shared/config/custom_color.dart';
import '../../../../../shared/config/size_config.dart';
import '../../../../../shared/widgets/campaign_card/all_campaigns_card.dart';
import '../../../data/models/campaign_model.dart';

class AllCampaignsScreen extends StatelessWidget {
  const AllCampaignsScreen({
    Key? key,
    required this.campaigns,
    required this.title,
  }) : super(key: key);

  final String title;
  final List<CampaignModel>? campaigns;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
        children: [
          ...(campaigns ?? [])
              .asMap()
              .map(
                (key, campaign) => MapEntry(
                  key,
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: (key == (campaigns?.length ?? 0) - 1)
                            ? BorderSide.none
                            : BorderSide(
                                color: UniversalColor.gray6,
                              ),
                      ),
                    ),
                    child: AllCampaignsCard(
                      campaign: campaign,
                    ),
                  ),
                ),
              )
              .values
              .toList(),
        ],
      ),
    );
  }
}
