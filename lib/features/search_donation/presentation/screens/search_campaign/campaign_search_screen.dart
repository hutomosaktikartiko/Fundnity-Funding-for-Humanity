import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/utils.dart';
import '../../../../../shared/config/custom_color.dart';
import '../../../../../shared/config/size_config.dart';
import '../../../../../shared/widgets/custom_app_bar_with_search_form.dart';
import '../../../../main/presentation/cubit/campaigns/campaigns_cubit.dart';
import '../../cubit/recommended_campaign/recommended_campaign_cubit.dart';
import 'states/empty.dart';
import 'states/error.dart';
import 'states/loaded.dart';
import 'states/loading.dart';

class CampaignSearchScreen extends StatefulWidget {
  const CampaignSearchScreen({Key? key}) : super(key: key);

  @override
  State<CampaignSearchScreen> createState() => _CampaignSearchScreenState();
}

class _CampaignSearchScreenState extends State<CampaignSearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithSearchForm(
        formHintText: "Type Children, Health, etc...",
        isShowBackButton: true,
        isAutoFocus: true,
        textEditingController: searchController,
        onChanged: _onChanged,
        suffixWidget: buildSuffixWidget(),
      ).build(context),
      body: GestureDetector(
        onTap: () => Utils.hideKeyboard(context),
        onPanDown: (_) => Utils.hideKeyboard(context),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              BlocBuilder<CampaignsCubit, CampaignsState>(
                builder: (context, state) {
                  if (state is CampaignsLoaded) {
                    context
                        .read<RecommendedCampaignCubit>()
                        .getRecommendedCampaigns(campaigns: state.campaigns);
                    return BlocBuilder<RecommendedCampaignCubit,
                            RecommendedCampaignState>(
                        builder: (context, recommendedCampaignState) {
                      if (recommendedCampaignState
                          is RecommendedCampaignLoaded) {
                        return Loaded(
                          campaigns: recommendedCampaignState.campaigns,
                          label: recommendedCampaignState.isSearching
                              ? "Results"
                              : "Campaigns for you",
                        );
                      } else if (state is RecommendedCampaignEmpty) {
                        return Empty();
                      }

                      return SizedBox.shrink();
                    });
                  } else if (state is CampaignsEmpty) {
                    return Empty();
                  } else if (state is CampaignsLoadingFailure) {
                    return Error(
                      message: state.message,
                    );
                  }

                  return Loading();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget? buildSuffixWidget() {
    // Check searchController.text != ""
    if (searchController.text != "") {
      // Show close button
      return GestureDetector(
        // Clear  searchController.text to ""
        onTap: () => setState(() => searchController.text = ""),
        child: Icon(
          Icons.close,
          color: UniversalColor.gray4,
        ),
      );
    }

    return null;
  }

  void _onChanged() {
    // Set RecommendedCampaignCubit result
    if (context.read<CampaignsCubit>().state is CampaignsLoaded) {
      context.read<RecommendedCampaignCubit>().getSearchCampaigns(
            keyword: searchController.text,
            campaigns: (context.read<CampaignsCubit>().state as CampaignsLoaded)
                .campaigns,
          );
    }

    // Rebuild Widget
    setState(() {});
  }
}
