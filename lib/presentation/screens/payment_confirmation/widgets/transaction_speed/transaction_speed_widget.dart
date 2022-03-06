import 'package:flutter/material.dart';

import '../../../../../core/config/custom_text_style.dart';
import '../../../../../data/models/mock_transaction_speed.dart';
import 'states/loaded.dart';

class TransactionSpeedWidget extends StatelessWidget {
  const TransactionSpeedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Transaction Speed",
          style: CustomTextStyle.gray1TextStyle.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Loaded(
          transactionSpeeds: mockListTransactionSpeeds,
        ),
      ],
    );
  }
}
