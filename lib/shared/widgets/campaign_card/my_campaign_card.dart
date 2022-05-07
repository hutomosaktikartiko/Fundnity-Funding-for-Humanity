import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../features/main/data/models/campaign_model.dart';
import '../../config/custom_color.dart';
import '../../config/custom_text_style.dart';
import '../../extension/big_int_parsing.dart';
import '../../extension/campaign_status_parsing.dart';
import '../../extension/string_parsing.dart';
import '../button/custom_button_label.dart';
import '../show_image/show_image_network.dart';

class MyCampaignCard extends StatelessWidget {
  const MyCampaignCard({
    Key? key,
    required this.campaign,
  }) : super(key: key);

  final CampaignModel? campaign;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: UniversalColor.gray4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShowImageNetwork(
                height: 70,
                width: 80,
                imageUrl: campaign?.image.stringHashImageToImageUrl() ?? "",
                borderRadius: BorderRadius.circular(5),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: SizedBox(
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        campaign?.title ?? "-",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: CustomTextStyle.gray2TextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: campaign?.status.campaignStatusToBgColor(),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          campaign?.status.campaignStatusToLabel() ?? "-",
                          style: CustomTextStyle.gray4TextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color:
                                campaign?.status?.campaignStatusToStrongColor(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          buildBottomWidget(),
        ],
      ),
    );
  }

  Widget buildBottomWidget() {
    if (campaign?.status == CampaignStatus.Inactive) {
      return CustomButtonLabel(
        label: "Re-Create Campaign",
        onTap: () {},
      );
    } else if (campaign?.status == CampaignStatus.Draft) {
      return CustomButtonLabel(
        label: "Continue Create Campaign",
        onTap: () {},
      );
    } else if (campaign?.status == CampaignStatus.Complete) {
      return CustomButtonLabel(
        label: "Claim Balance",
        onTap: () {},
      );
    } else if (campaign?.status == CampaignStatus.Claimed) {
      return CustomButtonLabel(
        label: "Balance Has Been Claimed",
        onTap: () {},
        backgroundColor: Colors.white,
        borderColor: UniversalColor.green4,
        labelColor: UniversalColor.green4,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: "${campaign?.balance.etherInWeiToEther()} ETH",
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
                text: (campaign?.endDate.bigIntTimeStampToIntDays() ?? 0)
                    .toString(),
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
          percent: campaign?.balance
                  .bigIntToPercentTargetMax1(target: campaign?.target) ??
              0,
          lineHeight: 8,
          barRadius: Radius.circular(3),
          padding: EdgeInsets.only(right: 5),
          progressColor: UniversalColor.green4,
          animation: true,
          trailing: Text(
            (campaign?.balance
                        ?.bigIntToPercentTarget(target: campaign?.target)
                        .toStringAsFixed(1) ??
                    "0") +
                "%",
            style: CustomTextStyle.green4TextStyle.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
