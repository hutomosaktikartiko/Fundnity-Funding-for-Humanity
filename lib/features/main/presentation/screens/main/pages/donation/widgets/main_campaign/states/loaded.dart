import 'package:flutter/material.dart';

import '../../../../../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../../../../shared/config/size_config.dart';
import '../../../../../../../../../../shared/widgets/campaign_card/horizontal_campaign_card.dart';
import '../../../../../../../../../../shared/widgets/widget_with_default_horizontal_padding.dart';
import '../../../../../../../../data/models/campaign_model.dart';
import '../../../../../../all_campaigns/all_campaigns_screen.dart';
import '../../view_all_widget.dart';

class Loaded extends StatelessWidget {
  const Loaded({
    Key? key,
    required this.campaigns,
  }) : super(key: key);

  final List<CampaignModel> campaigns;

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
              ViewAllWidget(
                onTap: () => _openAllMainCampaignScreen(context),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children:
                ((campaigns.length > 5) ? campaigns.sublist(0, 5) : campaigns)
                    .asMap()
                    .map(
                      (key, campaign) => MapEntry(
                        key,
                        Padding(
                          padding: EdgeInsets.only(
                            left: (key == 0) ? SizeConfig.defaultMargin : 15,
                            right: (key == campaigns.length - 1 || key == 4)
                                ? SizeConfig.defaultMargin
                                : 0,
                          ),
                          child: HorizontalCampaignCard(
                            campaign: campaign,
                          ),
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

  void _openAllMainCampaignScreen(BuildContext context) {
    ScreenNavigator.startScreen(context,
        AllCampaignsScreen(campaigns: campaigns, title: "Need to Help First"));
  }
}
