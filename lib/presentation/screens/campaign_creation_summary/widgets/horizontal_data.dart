import 'package:flutter/material.dart';

import '../../../../core/config/custom_text_style.dart';

class HorizontalData extends StatelessWidget {
  const HorizontalData({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String? title, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title ?? "-",
            style: CustomTextStyle.gray2TextStyle.copyWith(
              fontSize: 12,
            ),
          ),
        ),
        Text(
          value ?? "-",
          style: CustomTextStyle.gray2TextStyle.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
