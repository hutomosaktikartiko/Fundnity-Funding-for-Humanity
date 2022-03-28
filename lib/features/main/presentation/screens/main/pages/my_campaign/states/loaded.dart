import 'package:flutter/material.dart';

import '../../../../../../../../shared/widgets/custom_app_bar_with_search_form.dart';

class Loaded extends StatelessWidget {
  const Loaded({Key? key}) : super(key: key);

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
