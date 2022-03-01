import 'package:flutter/material.dart';

import '../../../../widgets/custom_app_bar_with_search_form.dart';

class MyCampaignPage extends StatelessWidget {
  const MyCampaignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithSearchForm(
        formHintText: "Search my campaign",
        openSearchScreen: _openSearchScreen,
      ).build(context),
    );
  }

  void _openSearchScreen() {
    // TODO => Navigator open search my campaign screen
  }
}
