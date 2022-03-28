import 'package:flutter/material.dart';

import '../../../../../../shared/config/custom_text_style.dart';

class CustomTextTitle extends StatelessWidget {
  const CustomTextTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: CustomTextStyle.gray2TextStyle.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
