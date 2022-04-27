import 'package:flutter/material.dart';

import '../../../../../../shared/config/custom_color.dart';
import '../../../../../../shared/config/custom_text_style.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              Icons.arrow_back,
              color: UniversalColor.gray3,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Back",
              style: CustomTextStyle.gray3TextStyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
