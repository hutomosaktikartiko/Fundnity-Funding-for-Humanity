import 'package:flutter/material.dart';

import '../widgets/donation_history_card.dart';

class Loaded extends StatelessWidget {
  const Loaded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...[1, 2, 3, 4, 5]
            .asMap()
            .map(
              (key, value) => MapEntry(
                key,
                Padding(
                  // TODO => Change [4] to real data length
                  padding: EdgeInsets.only(bottom: (key == 4) ? 0 : 10),
                  child: DonationHistoryCard(),
                ),
              ),
            )
            .values
            .toList(),
      ],
    );
  }
}
