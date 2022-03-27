import 'package:flutter/material.dart';

import '../../../shared/config/custom_color.dart';
import '../../../shared/config/custom_text_style.dart';
import 'custom_button.dart';

class CustomButtonLabel extends StatelessWidget {
  const CustomButtonLabel({
    Key? key,
    required this.label,
    required this.onTap,
    this.labelColor = Colors.white,
    this.paddingVertical = 12,
    this.paddingHorizontal = 12,
    this.backgroundColor = UniversalColor.green4,
    this.fontSize = 15,
    this.borderRadius = 5,
    this.width,
    this.borderColor = UniversalColor.green4,
  }) : super(key: key);

  final String label;
  final double? width;
  final double paddingVertical, fontSize, borderRadius, paddingHorizontal;
  final Function() onTap;
  final Color? labelColor;
  final Color backgroundColor, borderColor;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      child: Center(
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyle.gray1TextStyle.copyWith(
            color: labelColor,
            fontSize: fontSize,
          ),
        ),
      ),
      onTap: onTap,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      paddingVertical: paddingVertical,
      paddingHorizontal: paddingHorizontal,
      width: width,
    );
  }
}
