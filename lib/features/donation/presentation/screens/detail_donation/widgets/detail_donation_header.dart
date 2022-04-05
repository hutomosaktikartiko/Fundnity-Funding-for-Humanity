import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../../../shared/config/custom_color.dart';
import '../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../shared/config/size_config.dart';
import '../../../../../../shared/extension/big_int_parsing.dart';
import '../../../../../main/data/models/campaign_model.dart';
import '../../../cubit/contributor/contributor_cubit.dart';

class DetailDonationHeader extends StatelessWidget {
  final CampaignModel? campaign;

  const DetailDonationHeader({
    Key? key,
    required this.campaign,
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
            campaign?.title ?? "-",
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
                  text: "${campaign?.balance} ETH",
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
                  text: " ${campaign?.target} ETH",
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
              BlocBuilder<ContributorCubit, ContributorState>(
                builder: (context, state) {
                  return Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: (state is ContributorLoaded)
                              ? state.contributors.length.toString()
                              : "0",
                          style: CustomTextStyle.gray2TextStyle.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: " Donations",
                          style: CustomTextStyle.gray2TextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: (campaign?.endDate.bigIntTimeStampToIntDays() ?? 0).toString(),
                      style: CustomTextStyle.gray2TextStyle.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: " days left",
                      style: CustomTextStyle.gray2TextStyle.copyWith(
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
