import 'package:flutter/material.dart';

import '../../shared/config/custom_color.dart';
import '../../shared/config/custom_text_style.dart';

class IconWithCounter extends StatelessWidget {
  const IconWithCounter({
    Key? key,
    required this.counter,
    required this.icon,
  }) : super(key: key);

  final Icon icon;
  final String counter;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        icon,
        Positioned(
          right: 0,
          width: 16,
          height: 12,
          child: Container(
            width: 16,
            height: 12,
            decoration: BoxDecoration(
              color: UniversalColor.dangerClicked,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: Text(
                counter,
                style: CustomTextStyle.whiteTextStyle.copyWith(
                  fontSize: 8,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
