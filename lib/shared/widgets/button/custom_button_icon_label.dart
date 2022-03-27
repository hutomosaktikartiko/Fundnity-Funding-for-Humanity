import 'package:flutter/material.dart';

import '../../../shared/config/custom_color.dart';
import '../../../shared/config/custom_text_style.dart';
import 'custom_button.dart';

class CustomButtonLabelIconLabel extends StatelessWidget {
  const CustomButtonLabelIconLabel({
    Key? key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.labelColor = Colors.white,
    this.paddingVertical = 12,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.spaceWidth = 0,
    this.backgroundColor = UniversalColor.green4,
    this.fontSize = 12,
    this.borderRadius = 10,
    this.iconSize = 30,
    this.width,
    this.borderColor = UniversalColor.green4,
  }) : super(key: key);

  final String label;
  final double? width;
  final double paddingVertical, fontSize, borderRadius, iconSize, spaceWidth;
  final Function() onTap;
  final Color? labelColor;
  final Color backgroundColor, borderColor;
  final Widget icon;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          icon,
          SizedBox(
            width: spaceWidth,
          ),
          Text(
            label,
            style: CustomTextStyle.gray1TextStyle.copyWith(
              color: labelColor,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
      onTap: onTap,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      paddingVertical: paddingVertical,
      width: width,
    );
  }
}
