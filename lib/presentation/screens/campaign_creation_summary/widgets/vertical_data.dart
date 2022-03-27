import 'package:flutter/material.dart';

import '../../../../shared/config/custom_color.dart';
import '../../../../shared/config/custom_text_style.dart';
import '../../../../shared/config/size_config.dart';

class VerticalData extends StatelessWidget {
  const VerticalData({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String? title, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "-",
          style: CustomTextStyle.gray2TextStyle.copyWith(
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: SizeConfig.screenWidth,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: UniversalColor.gray6,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            value ?? "-",
            style: CustomTextStyle.gray2TextStyle.copyWith(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
