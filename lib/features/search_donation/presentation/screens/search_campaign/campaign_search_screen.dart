import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/utils.dart';
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

  void _onChanged() {
    context.read<RecommendedCampaignCubit>().getSearchCampaigns(
          keyword: searchController.text,
        );
    // Sudah berhasil search
    // Tapi
    // FIXME
    // Terdapat butuh 2 result yang berbeda
    // 1 -> result recommended campaign -> Ketika keyword yang diinputkan masih kosong (baru masuk atau keyword yang diinputkan kosong)
    // 2 -> result search campaign -> Result dari keyword yang diinputkan
  }
}
