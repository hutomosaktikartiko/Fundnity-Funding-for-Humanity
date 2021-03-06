import 'package:flutter/material.dart';

import '../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../shared/widgets/campaign_card/vertical_campaign_card.dart';
import '../../../../../main/data/models/campaign_model.dart';

class Loaded extends StatelessWidget {
  const Loaded({
    Key? key,
    required this.campaigns,
    required this.label,
  }) : super(key: key);

  final List<CampaignModel> campaigns;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
             label,
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
    );
  }
}
