import 'package:flutter/material.dart';

import '../../../../widgets/custom_app_bar_with_search_form.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithSearchForm(
        formHintText: "Search history",
        openSearchScreen: _openSearchScreen,
      ).build(context),
    );
  }

  void _openSearchScreen() {
    // TODO => Navigator open search history screen
  }
}
