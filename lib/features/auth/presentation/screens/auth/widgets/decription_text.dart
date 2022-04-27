import 'package:flutter/material.dart';

import '../../../../../../shared/config/custom_text_style.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: CustomTextStyle.gray2TextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
