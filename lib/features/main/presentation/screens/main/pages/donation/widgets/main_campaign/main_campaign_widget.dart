import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../cubit/campaigns/campaigns_cubit.dart';
import '../../../../../../cubit/main_campaign/main_campaign_cubit.dart';
import 'states/empty.dart';
import 'states/error.dart';
import 'states/loaded.dart';
import 'states/loading.dart';

class MainCampaignWidget extends StatelessWidget {
  const MainCampaignWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CampaignsCubit, CampaignsState>(
      listener: (context, state) {
        if (state is CampaignsLoaded) {
          context
              .read<MainCampaignCubit>()
              .getMainCampaigns(campaigns: state.campaigns);
        } else if (state is CampaignsLoadingFailure) {
          context
              .read<MainCampaignCubit>()
              .emit(MainCampaignLoadingFailure(message: state.message));
        }
      },
      builder: (context, state) {
        if (state is CampaignsLoaded) {
          return BlocBuilder<MainCampaignCubit, MainCampaignState>(
            builder: (context, mainCampaignState) {
              if (mainCampaignState is MainCampaignLoaded) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Loaded(
                    campaigns: state.campaigns,
                  ),
                );
              } else if (mainCampaignState is MainCampaignEmpty) {
                return Empty();
              } else if (mainCampaignState is MainCampaignLoadingFailure) {
                return Error(
                  message: mainCampaignState.message,
                );
              } else {
                return SizedBox.shrink();
              }
            },
          );
        } else if (state is CampaignsLoading) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Loading(),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
