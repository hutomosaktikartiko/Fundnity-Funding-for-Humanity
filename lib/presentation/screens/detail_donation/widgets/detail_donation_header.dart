import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/config/custom_color.dart';
import '../../../../core/config/custom_text_style.dart';
import '../../../../core/config/size_config.dart';

class DetailDonationHeader extends StatelessWidget {
  const DetailDonationHeader({
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
            "Help Avisa to Continue Her College Study on Stanford University",
            style: CustomTextStyle.gray2TextStyle.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "125 ETH",
                  style: CustomTextStyle.green4TextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: " Funds Collected",
                  style: CustomTextStyle.gray2TextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                TextSpan(
                  text: " from",
                  style: CustomTextStyle.green4TextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: " 1000 ETH",
                  style: CustomTextStyle.gray2TextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          LinearPercentIndicator(
            percent: 0.25,
            lineHeight: 8,
            barRadius: Radius.circular(3),
            padding: EdgeInsets.only(right: 5),
            progressColor: UniversalColor.green4,
            animation: true,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "1120",
                      style:
                          CustomTextStyle.gray2TextStyle.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: " Donations",
                      style:
                          CustomTextStyle.gray2TextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "60",
                      style:
                          CustomTextStyle.gray2TextStyle.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: " days left",
                      style:
                          CustomTextStyle.gray2TextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
