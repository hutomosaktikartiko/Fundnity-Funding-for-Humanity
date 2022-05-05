import '../widgets/history_card.dart';
import '../../../../../../../../shared/config/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/history_model.dart';

class Loaded extends StatelessWidget {
  const Loaded({
    Key? key,
    required this.history,
  }) : super(key: key);

  final List<HistoryModel> history;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
        children: history
            .asMap()
            .map(
              (key, value) => MapEntry(
                key,
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: HistoryCard(history: value),
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }
}
