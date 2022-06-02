import 'package:flutter/material.dart';

import '../../../../shared/widgets/custom_app_bar_with_search_form.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithSearchForm(
        formHintText: "Type Children, Health, etc...",
        isShowBackButton: true,
        isAutoFocus: true,
      ).build(context),
      body: ListView(),
    );
  }
}
