import 'package:flutter/material.dart';

import '../../shared/config/size_config.dart';

class WidgetWithDefaultHorizontalPadding extends StatelessWidget {
  const WidgetWithDefaultHorizontalPadding({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
      child: child,
    );
  }
}
