import 'package:flutter/material.dart';

import '../../../../../../data/models/campaign_model.dart';

class Loaded extends StatelessWidget {
  const Loaded({
    Key? key,
    required this.campaigns,
  }) : super(key: key);

  final List<CampaignModel> campaigns;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Loaded"),
    );
  }
}
