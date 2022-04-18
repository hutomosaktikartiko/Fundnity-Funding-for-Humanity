import 'package:flutter/material.dart';

import '../../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../../shared/config/custom_text_style.dart';

class FilterCampaignCard extends StatelessWidget {
  const FilterCampaignCard({
    Key? key,
    required this.filter,
    required this.isActive,
  }) : super(key: key);

  final String? filter;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: (isActive) ? UniversalColor.green4 : Colors.white,
          border: Border.all(color: (isActive) ? UniversalColor.green4 : UniversalColor.gray4),
        ),
        child: Text(
          filter ?? "-",
          style: CustomTextStyle.gray2TextStyle.copyWith(
            fontSize: 13,
            color: (isActive) ? Colors.white : UniversalColor.gray4,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
