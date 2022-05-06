import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../core/utils/screen_navigator.dart';
import '../../../features/donation/presentation/screens/detail_donation/detail_donation_screen.dart';
import '../../../features/main/data/models/campaign_model.dart';
import '../../config/custom_color.dart';
import '../../config/custom_text_style.dart';
import '../../extension/big_int_parsing.dart';
import '../../extension/string_parsing.dart';
import '../show_image/show_image_network.dart';

class AllCampaignsCard extends StatelessWidget {
  const AllCampaignsCard({
    Key? key,
    required this.campaign,
  }) : super(key: key);

  final CampaignModel? campaign;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDetailCampaignScreen(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShowImageNetwork(
            imageUrl: campaign?.image?.stringHashImageToImageUrl() ?? "",
            width: 170,
            height: 100,
            borderRadius: BorderRadius.circular(5),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    campaign?.title ?? "-",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.gray1TextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaign?.address.toString().walletAddressSplit() ??
                            "-",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyle.gray1TextStyle.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      LinearPercentIndicator(
                        percent: campaign?.balance
                                    ?.bigIntToPercentTargetMax1(
                                        target: campaign?.target) ??
                                0,
                        lineHeight: 5,
                        barRadius: Radius.circular(1),
                        padding: EdgeInsets.only(right: 5),
                        progressColor: UniversalColor.green4,
                        animation: true,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildOther(
                        title: "Found",
                        value:
                            "${campaign?.balance.etherInWeiToEther().toString() ?? 0} ETH",
                      ),
                      buildOther(
                        title: "Days left",
                        value: campaign?.endDate
                                .bigIntTimeStampToIntDays()
                                .toString() ??
                            "-",
                        crossAxisAlignment: CrossAxisAlignment.end,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildOther({
    required String title,
    required String value,
    CrossAxisAlignment? crossAxisAlignment,
  }) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: CustomTextStyle.gray1TextStyle.copyWith(
            fontSize: 10,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: CustomTextStyle.gray1TextStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _openDetailCampaignScreen(BuildContext context) {
    ScreenNavigator.startScreen(
        context, DetailDonationScreen(campaign: campaign));
  }
}
