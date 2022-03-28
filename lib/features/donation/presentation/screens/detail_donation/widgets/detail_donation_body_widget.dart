import 'package:flutter/material.dart';

import '../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../shared/config/size_config.dart';
import '../../../../../../shared/widgets/user_address_card/user_address_horizontal_card.dart';


class DetailDonationBody extends StatelessWidget {
  const DetailDonationBody({
    Key? key,
  }) : super(key: key);

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
          Text(
            "Fundraiser",
            style: CustomTextStyle.gray2TextStyle.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // TODO => Change address to real data
          UserAddressHorizontalCard(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Description",
            style: CustomTextStyle.gray2TextStyle.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // TODO => Change to real description data
          Text(
            "Help Avisa to Continue Her College Study on Stanford University Help Avisa to Continue Her College Study on Stanford University Help Avisa to Continue Her College Study on Stanford University Help Avisa to Continue Her College Study on Stanford University",
            style: CustomTextStyle.gray2TextStyle.copyWith(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}