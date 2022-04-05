import 'package:flutter/material.dart';

import '../../../../../../data/models/contributor_model.dart';
import '../widgets/donation_history_card.dart';

class Loaded extends StatelessWidget {
  const Loaded({
    Key? key,
    required this.contributors,
  }) : super(key: key);

  final List<ContributorModel?> contributors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...(contributors)
            .asMap()
            .map(
              (key, contributor) => MapEntry(
                key,
                Padding(
                  padding: EdgeInsets.only(
                      bottom: (key == contributors.length) ? 0 : 10),
                  child: DonationHistoryCard(
                    contributor: contributor,
                  ),
                ),
              ),
            )
            .values
            .toList(),
      ],
    );
  }
}
