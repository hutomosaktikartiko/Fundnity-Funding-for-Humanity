import 'package:flutter/material.dart';

import '../../../core/config/size_config.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.paddingVertical = 12,
    required this.backgroundColor,
    this.borderRadius = 10,
    this.width,
    required this.borderColor,
  }) : super(key: key);

  final double? width;
  final Widget child;
  final double paddingVertical, borderRadius;
  final Function() onTap;
  final Color backgroundColor, borderColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius)
        )
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: paddingVertical),
        width: width ?? SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: child,
      ),
    );
  }
}
