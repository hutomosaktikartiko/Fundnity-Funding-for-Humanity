import 'package:flutter/material.dart';

import '../../../../shared/config/custom_color.dart';

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget({
    Key? key,
    required this.index,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(microseconds: 150),
      margin: EdgeInsets.only(left: (index == 0) ? 0 : 10),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? UniversalColor.green4 : UniversalColor.gray5,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
