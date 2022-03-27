import 'package:flutter/material.dart';

import '../../../../../../../../data/models/campaign_model.dart';
import '../../../../../../../../shared/config/size_config.dart';
import '../../../../../../../../shared/widgets/custom_box_shadow.dart';

class Loaded extends StatelessWidget {
  const Loaded({
    Key? key,
    required this.campaign,
  }) : super(key: key);

  final CampaignModel campaign;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          CustomBoxShadow.defaultBoxShadow(),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          Text(
            campaign.title ?? "-",
          ),
        ],
      ),
    );
  }
}
