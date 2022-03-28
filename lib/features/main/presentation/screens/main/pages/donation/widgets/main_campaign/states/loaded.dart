import 'package:flutter/material.dart';

import '../../../../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../../../../shared/config/size_config.dart';
import '../../../../../../../../../../shared/widgets/campaign_card/horizontal_campaign_card.dart';
import '../../../../../../../../../../shared/widgets/widget_with_default_horizontal_padding.dart';
import '../../view_all_widget.dart';

class Loaded extends StatelessWidget {
  const Loaded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetWithDefaultHorizontalPadding(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Need to Help First",
                style: CustomTextStyle.blackTextStyle.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ViewAllWidget(onTap: _openAllMainCampaignScreen),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [0, 1, 2, 3, 4, 5]
                .asMap()
                .map(
                  (key, value) => MapEntry(
                    key,
                    Padding(
                      padding: EdgeInsets.only(
                        left: (key == 0) ? SizeConfig.defaultMargin : 15,
                        right: (key == 5) ? SizeConfig.defaultMargin : 0,
                      ),
                      child: HorizontalCampaignCard(),
                    ),
                  ),
                )
                .values
                .toList(),
          ),
        ),
      ],
    );
  }

  void _openAllMainCampaignScreen() {
    // TODO => Navigator to Main Donation Screen
  }
}
