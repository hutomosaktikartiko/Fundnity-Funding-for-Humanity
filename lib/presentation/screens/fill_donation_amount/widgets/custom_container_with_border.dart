import 'package:flutter/material.dart';

import '../../../../shared/config/custom_color.dart';
import '../../../../shared/config/size_config.dart';

class CustomContainerWithBorder extends StatelessWidget {
  const CustomContainerWithBorder({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.defaultMargin,
        horizontal: SizeConfig.defaultMargin - 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: UniversalColor.gray5,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }
}
