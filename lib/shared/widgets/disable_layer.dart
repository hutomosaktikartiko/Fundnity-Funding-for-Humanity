import 'package:crowdfunding/shared/config/custom_text_style.dart';
import 'package:crowdfunding/shared/config/size_config.dart';
import 'package:flutter/material.dart';

class DisabledLayer extends StatelessWidget {
  const DisabledLayer({
    Key? key,
    this.disabled = false,
    this.height,
    this.width,
    this.borderRadius,
    this.message,
    this.layerColor,
  }) : super(key: key);

  final bool? disabled;
  final double? height, width, borderRadius;
  final String? message;
  final Color? layerColor;

  @override
  Widget build(BuildContext context) {
    if (disabled == true) {
      return Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
        decoration: BoxDecoration(
          color: layerColor ?? Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        child: Center(
          child: Text(
            message ?? "",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyle.blackTextStyle.copyWith(fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return SizedBox.shrink();
  }
}