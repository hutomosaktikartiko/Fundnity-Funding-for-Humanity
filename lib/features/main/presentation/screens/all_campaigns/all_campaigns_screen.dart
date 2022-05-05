import 'package:flutter/material.dart';

import '../../../data/models/campaign_model.dart';
import 'states/empty.dart';
import 'states/loaded.dart';

class AllCampaignsScreen extends StatelessWidget {
  const AllCampaignsScreen({
    Key? key,
    required this.campaigns,
    required this.title,
  }) : super(key: key);

  final String title;
  final List<CampaignModel>? campaigns;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if ((campaigns?.length ?? 0) < 1) {
      return Empty();
    } else {
      return Loaded(
        campaigns: campaigns,
      );
    }
  }
}
