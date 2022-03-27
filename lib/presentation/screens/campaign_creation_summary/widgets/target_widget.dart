import 'package:flutter/material.dart';

import '../../../../shared/config/custom_color.dart';
import '../../../../shared/config/size_config.dart';
import '../../../../core/utils/screen_navigator.dart';
import '../../create_campaign/create_campaign_screen.dart';
import 'horizontal_data.dart';
import 'review_card.dart';

class TargetWidget extends StatelessWidget {
  const TargetWidget({
    Key? key,
    required this.amount,
    required this.time,
  }) : super(key: key);

  final double? amount;
  final int? time;

  @override
  Widget build(BuildContext context) {
    return ReviewCard(
      onEdit: () => _onEdit(context),
      number: "1",
      title: "Donation Target",
      bodyCard: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HorizontalData(
              title: "Cost reqruitment",
              value: "${amount ?? 0}",
            ),
            Divider(
              height: 30,
              thickness: 1,
              color: UniversalColor.gray5,
            ),
            HorizontalData(
              title: "Campaign time",
              value: "${time ?? 0} days",
            ),
          ],
        ),
      ),
    );
  }

  void _onEdit(BuildContext context) {
    ScreenNavigator.startScreen(context, CreateCampaignScreen(index: 0));
  }
}
