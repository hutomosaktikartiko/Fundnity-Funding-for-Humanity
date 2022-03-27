import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../core/utils/screen_navigator.dart';
import '../../../presentation/screens/detail_donation/detail_donation_screen.dart';
import '../../../shared/config/custom_color.dart';
import '../../../shared/config/custom_text_style.dart';
import '../custom_box_shadow.dart';
import '../show_image/show_image_network.dart';

class VerticalCampaignCard extends StatelessWidget {
  const VerticalCampaignCard({
    Key? key,
  }) : super(key: key);

  // TODO => Add parameter CampaignModel

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDetailCampaignScreen(context),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            CustomBoxShadow.defaultBoxShadow(),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowImageNetwork(
              imageUrl: "",
              boxFit: BoxFit.cover,
              width: 80,
              height: 80,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(10),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Help Avisa to Continue Her College Study on Stanford University",
                      style: CustomTextStyle.gray2TextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "125 ETH",
                            style: CustomTextStyle.green4TextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: " Funds Collected |",
                            style: CustomTextStyle.gray3TextStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: " 15",
                            style: CustomTextStyle.green4TextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: " Days left",
                            style: CustomTextStyle.gray3TextStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    LinearPercentIndicator(
                      percent: 0.25,
                      lineHeight: 8,
                      barRadius: Radius.circular(3),
                      padding: EdgeInsets.only(
                        right: 5
                      ),
                      trailing: Text(
                        "25%",
                        style: CustomTextStyle.green4TextStyle.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      progressColor: UniversalColor.green4,
                      animation: true,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _openDetailCampaignScreen(BuildContext context) {
    ScreenNavigator.startScreen(context, DetailDonationScreen());
  }
}
