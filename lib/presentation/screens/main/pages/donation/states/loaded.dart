import 'package:flutter/material.dart';

import '../widgets/campaign/campaign_widget.dart';

class Loaded extends StatelessWidget {
  const Loaded({
    Key? key,
    required this.listAddresses,
  }) : super(key: key);

  final List<dynamic> listAddresses;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: listAddresses
            .asMap()
            .map((key, address) =>
                MapEntry(key, Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CampaignWidget(campaignAddress: address.toString()),
                )))
            .values
            .toList(),
      ),
    );
  }
}
