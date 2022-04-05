import 'package:flutter/material.dart';

import '../../../../../../../../shared/config/custom_text_style.dart';

class DonationHistoryHeader extends StatelessWidget {
  final int total;
  final Widget child;

  const DonationHistoryHeader({
    Key? key,
    required this.child,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Donations ($total)",
          style: CustomTextStyle.gray2TextStyle.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        child,
      ],
    );
  }
}
