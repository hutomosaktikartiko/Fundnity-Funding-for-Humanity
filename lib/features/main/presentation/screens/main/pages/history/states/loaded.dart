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
        children: history
            .map(
              (e) => ListTile(
                title: Text(e.category.toString()),
                subtitle: Text(e.date.toString()),
              ),
            )
            .toList(),
      ),
    );
  }
}
