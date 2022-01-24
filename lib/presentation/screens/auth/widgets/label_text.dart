import 'package:flutter/material.dart';

import '../../../../core/config/custom_text_style.dart';

class LabelText extends StatelessWidget {
  const LabelText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: CustomTextStyle.blackTextStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
