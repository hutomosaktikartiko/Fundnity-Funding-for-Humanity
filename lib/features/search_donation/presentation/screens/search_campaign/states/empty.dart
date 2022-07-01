import 'package:flutter/material.dart';

import '../../../../../../shared/config/size_config.dart';
import '../../../../../../shared/widgets/states/empty_campaign.dart';

class Empty extends StatelessWidget {
  const Empty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight / 1.5,
      child: EmptyCampaign(
        height: 200,
        title: "Campaign is empty",
        description: "Please try again later after a few minutes",
      ),
    );
  }
}
