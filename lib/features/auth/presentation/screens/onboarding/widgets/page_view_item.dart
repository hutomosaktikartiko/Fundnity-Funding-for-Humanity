import 'package:flutter/material.dart';

import '../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../shared/config/size_config.dart';
import '../../../../data/models/onboarding_model.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    Key? key,
    required this.onboarding,
  }) : super(key: key);

  final OnboardingModel? onboarding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 180,
            width: 190,
            child: Image.asset(
              "assets/images/onboarding/${onboarding?.imageName}",
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
            child: Text(
              onboarding?.label ?? "-",
              style: CustomTextStyle.green4TextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
            child: Text(
              onboarding?.description ?? "-",
              style: CustomTextStyle.gray3TextStyle.copyWith(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
