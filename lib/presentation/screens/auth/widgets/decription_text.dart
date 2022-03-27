import 'package:flutter/material.dart';

import '../../../../shared/config/custom_text_style.dart';

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
      style: CustomTextStyle.gray3TextStyle.copyWith(fontSize: 12),
    );
  }
}
