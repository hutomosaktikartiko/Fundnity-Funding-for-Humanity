import 'package:crowdfunding/core/config/custom_text_style.dart';
import 'package:crowdfunding/core/config/size_config.dart';
import 'package:flutter/material.dart';

import 'states/loaded.dart';

class DonationHistoryWidget extends StatelessWidget {
  const DonationHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.defaultMargin + 5,
        horizontal: SizeConfig.defaultMargin,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO => Change [100] to real total of participants
          Text(
            "Donations (100)",
            style: CustomTextStyle.gray2TextStyle.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Loaded()
        ],
      ),
    );
  }
}
