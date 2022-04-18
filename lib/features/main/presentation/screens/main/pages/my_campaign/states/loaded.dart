import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../../shared/config/size_config.dart';
import '../../../../../../../../shared/widgets/campaign_card/my_campaign_card.dart';
import '../../../../../../../../shared/widgets/widget_with_default_horizontal_padding.dart';
import '../../../../../../../create_campaign/presentation/screens/create_campaign/create_campaign_screen.dart';
import '../../../../../../data/models/campaign_model.dart';
import '../../../../../cubit/campaigns/campaigns_cubit.dart';
import '../../../../../cubit/crowdfunding_deployed_contract/crowdfunding_deployed_contract_cubit.dart';
import '../../../../../cubit/web3client/web3client_cubit.dart';
import '../widgets/filter_widget.dart';

class Loaded extends StatelessWidget {
  const Loaded({
    Key? key,
    required this.campaigns,
  }) : super(key: key);

  final List<CampaignModel> campaigns;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Campaign"),
      ),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            WidgetWithDefaultHorizontalPadding(
              child: Text(
                "Create campaign",
                style: CustomTextStyle.gray2TextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () => _onCreateCampaign(context),
              child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: UniversalColor.green4,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "Create new campaign+",
                  style: CustomTextStyle.green4TextStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () => _onSeeGuideForCreatingCampaign(context),
              child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: BackgroundColor.bgBlue,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.help,
                      color: UniversalColor.green4,
                      size: 13,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: "Confused about how to create a campaign?",
                              style: CustomTextStyle.gray2TextStyle.copyWith(
                                fontSize: 10,
                              ),
                            ),
                            TextSpan(
                              text: " See the guide for creating a campaign",
                              style: CustomTextStyle.green4TextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 15,
              color: BackgroundColor.bgGray,
            ),
            const SizedBox(
              height: 20,
            ),
            WidgetWithDefaultHorizontalPadding(
              child: Text(
                "Manage campaign",
                style: CustomTextStyle.gray2TextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            FilterWidget(),
            const SizedBox(
              height: 15,
            ),
            WidgetWithDefaultHorizontalPadding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: campaigns
                    .asMap()
                    .map(
                      (key, campaign) => MapEntry(
                        key,
                        MyCampaignCard(
                          campaign: campaign,
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    await context.read<CampaignsCubit>().getCampaigns(
          web3Client: context.read<Web3ClientCubit>().state.web3client,
          crowdfundindContract: (context
                  .read<CrowdfundingDeployedContractCubit>()
                  .state as CrowdfundingDeployedContractLoaded)
              .deployedContract,
        );
  }

  void _onCreateCampaign(BuildContext context) {
    ScreenNavigator.startScreen(context, CreateCampaignScreen());
  }

  void _onSeeGuideForCreatingCampaign(BuildContext context) {
    // TODO: Navigator to guide how to createing a campaign screen
  }
}
