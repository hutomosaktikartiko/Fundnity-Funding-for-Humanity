import 'package:flutter/material.dart';

import '../../../../shared/config/size_config.dart';
import '../../../../core/utils/screen_navigator.dart';
import '../../create_campaign/create_campaign_screen.dart';
import 'review_card.dart';
import 'vertical_data.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String? description;

  @override
  Widget build(BuildContext context) {
    return ReviewCard(
      onEdit: () => _onEdit(context),
      number: "3",
      title: "Description",
      bodyCard: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalData(
              title: "Campaign description",
              value: description,
            ),
          ],
        ),
      ),
    );
  }

  void _onEdit(BuildContext context) {
    ScreenNavigator.startScreen(context, CreateCampaignScreen(index: 2));
  }
}
