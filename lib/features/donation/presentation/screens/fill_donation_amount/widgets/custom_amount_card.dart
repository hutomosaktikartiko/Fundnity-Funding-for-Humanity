import 'package:flutter/material.dart';

import '../../../../../../shared/config/custom_color.dart';
import '../../../../../../shared/config/custom_text_style.dart';
import '../../../../data/models/donation_amount_model.dart';
import 'custom_container_with_border.dart';

class CustomAmountCard extends StatelessWidget {
  const CustomAmountCard({
    Key? key,
    required this.amount,
  }) : super(key: key);

  final DonationAmountModel? amount;

  @override
  Widget build(BuildContext context) {
    return CustomContainerWithBorder(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${amount?.amountInString ?? 0} ETH",
            style: CustomTextStyle.gray2TextStyle.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: UniversalColor.gray4,
            size: 15,
          )
        ],
      ),
    );
  }
}
