import 'package:flutter/material.dart';

import 'states/loaded.dart';

class MainCampaignWidget extends StatelessWidget {
  const MainCampaignWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Loaded(),
    );
  }
}
