import 'package:flutter/material.dart';

import '../../../../../../../core/config/custom_color.dart';

class TargetDayItem extends StatelessWidget {
  const TargetDayItem({
    Key? key,
    required this.isActive,
    required this.text,
    required this.width,
  }) : super(key: key);

  final bool isActive;
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: (isActive) ? BackgroundColor.bgGreen : Colors.white,
        border: Border.all(
          color: (isActive) ? UniversalColor.green4 : UniversalColor.gray4,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Container(
            height: 15,
            width: 15,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    (isActive) ? UniversalColor.green4 : UniversalColor.gray4,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isActive) ? UniversalColor.green4 : Colors.transparent,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(text),
        ],
      ),
    );
  }
}
