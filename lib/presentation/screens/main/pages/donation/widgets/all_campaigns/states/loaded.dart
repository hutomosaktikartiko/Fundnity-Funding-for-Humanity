import 'package:flutter/material.dart';

import '../../../../../../../../core/config/custom_text_style.dart';
import '../../../../../../../widgets/campaign_card/vertical_campaign_card.dart';
import '../../view_all_widget.dart';

class Loaded extends StatelessWidget {
  const Loaded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Latest Campaign",
              style: CustomTextStyle.blackTextStyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            ViewAllWidget(
              onTap: _openAllLatestCampaigns,
            ),
          ],
        ),
        ...[0, 1, 2, 3, 4, 5]
            .asMap()
            .map(
              (key, value) => MapEntry(
                key,
                Padding(
                  padding: EdgeInsets.only(
                    top: (key == 0) ? 10 : 0,
                    bottom: 10,
                  ),
                  child: VerticalCampaignCard(),
                ),
              ),
            )
            .values
            .toList(),
      ],
    );
  }

  void _openAllLatestCampaigns() {
    // TODO => Show All Wallet Addresses bottom sheet
  }
}
