import 'package:flutter/material.dart';

import '../../../../../../shared/config/custom_color.dart';
import '../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../data/models/mock_transaction_speed.dart';

class TransactionSpeedCard extends StatelessWidget {
  const TransactionSpeedCard({
    Key? key,
    required this.isActive,
    required this.transactionSpeed,
  }) : super(key: key);

  final MockTransactionSpeed? transactionSpeed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: (isActive) ? UniversalColor.green4 : UniversalColor.gray5,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    (isActive) ? UniversalColor.green4 : UniversalColor.gray5,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactionSpeed?.title ?? "-",
                      style: CustomTextStyle.gray1TextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Gas Price ${transactionSpeed?.gasPrice ?? 0} GWEI",
                      style: CustomTextStyle.gray2TextStyle.copyWith(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                Text(
                  "< ${transactionSpeed?.speed ?? 0}",
                  style: CustomTextStyle.gray3TextStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
