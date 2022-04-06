import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/utils/screen_navigator.dart';
import '../../../features/donation/presentation/screens/detail_donation/detail_donation_screen.dart';
import '../../../features/main/data/models/campaign_model.dart';
import '../../../shared/config/custom_color.dart';
import '../../../shared/config/custom_text_style.dart';
import '../../../shared/config/size_config.dart';
import '../../extension/big_int_parsing.dart';
import '../../extension/string_parsing.dart';
import '../custom_box_shadow.dart';
import '../show_image/show_image_network.dart';

class HorizontalCampaignCard extends StatelessWidget {
  const HorizontalCampaignCard({
    Key? key,
    required this.campaign,
  }) : super(key: key);

  final CampaignModel? campaign;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDetailCampaignScreen(context),
      child: Container(
        width: SizeConfig.screenWidth - SizeConfig.defaultMargin * 3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [CustomBoxShadow.defaultBoxShadow()],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowImageNetwork(
              imageUrl: campaign?.image.stringHashImageToImageUrl() ?? "",
              boxFit: BoxFit.cover,
              height: 150,
              width: SizeConfig.screenWidth,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          campaign?.title ?? "-",
                          style: CustomTextStyle.gray2TextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      CircularPercentIndicator(
                        radius: 20,
                        lineWidth: 3,
                        percent: (campaign?.balance
                                .bigIntToCalculatePercentDouble(
                                    target: campaign?.target) ?? 0)/
                            100,
                        center: Text(
                          (campaign?.balance
                                  .bigIntToCalculatePercentDouble(
                                      target: campaign?.target)
                                  .toStringAsFixed(1) ?? "0") +
                              "%",
                          style: CustomTextStyle.gray3TextStyle.copyWith(
                            fontSize: 11,
                          ),
                        ),
                        progressColor: UniversalColor.green4,
                        animation: true,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "${campaign?.balance ?? 0} ETH",
                          style: CustomTextStyle.green4TextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: " Funds Collected | ",
                          style: CustomTextStyle.gray3TextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: (campaign?.endDate.bigIntTimeStampToIntDays() ?? 0).toString(),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _openDetailCampaignScreen(BuildContext context) {
    ScreenNavigator.startScreen(
        context, DetailDonationScreen(campaign: campaign));
  }
}
