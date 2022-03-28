import 'package:flutter/material.dart';

import 'states/loaded.dart';

class CampaignByWalletAddressWidget extends StatelessWidget {
  const CampaignByWalletAddressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Loaded(),
    );
  }
}
