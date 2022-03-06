import 'package:flutter/material.dart';

import '../../../../../../core/config/custom_text_style.dart';

class DetailAmountCard extends StatelessWidget {
  final String title;
  final int? value;
  final bool isBold;

  const DetailAmountCard({
    Key? key,
    required this.title,
    required this.value,
    this.isBold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: CustomTextStyle.gray2TextStyle.copyWith(
              fontSize: 15,
              fontWeight: (isBold) ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ),
        Text(
          "$value ETH",
          style: CustomTextStyle.gray2TextStyle.copyWith(
            fontSize: 15,
            fontWeight: (isBold) ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
