import 'package:flutter/material.dart';

import '../../../../../../../../shared/config/custom_text_style.dart';

class ViewAllWidget extends StatelessWidget {
  const ViewAllWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        "View all",
        style: CustomTextStyle.activeLinkTextStyle.copyWith(
          fontSize: 12,
        ),
      ),
    );
  }
}
