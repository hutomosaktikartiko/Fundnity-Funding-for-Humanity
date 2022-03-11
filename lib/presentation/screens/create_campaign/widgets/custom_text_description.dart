import 'package:flutter/material.dart';

import '../../../../core/config/custom_text_style.dart';

class CustomTextDescription extends StatelessWidget {
  const CustomTextDescription({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: CustomTextStyle.gray2TextStyle.copyWith(
        fontSize: 10,
      ),
    );
  }
}
