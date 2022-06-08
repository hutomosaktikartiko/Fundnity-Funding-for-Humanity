import 'package:flutter/material.dart';

import '../../../../../../../../../../shared/widgets/campaign_card/my_campaign_card.dart';
import '../../../../../../../../data/models/campaign_model.dart';

class Loaded extends StatelessWidget {
  const Loaded({
    Key? key,
    required this.campaign,
  }) : super(key: key);

  final CampaignModel? campaign;

  @override
  Widget build(BuildContext context) {
    return MyCampaignCard(campaign: campaign);
  }
}
