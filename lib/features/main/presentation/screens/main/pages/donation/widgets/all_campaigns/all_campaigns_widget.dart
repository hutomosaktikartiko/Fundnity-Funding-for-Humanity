import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../shared/widgets/widget_with_default_horizontal_padding.dart';
import '../../../../../../cubit/latest_campaigns/latest_campaigns_cubit.dart';
import '../../../../../../cubit/campaigns/campaigns_cubit.dart';
import 'states/empty.dart';
import 'states/error.dart';
import 'states/loaded.dart';
import 'states/loading.dart';

class AllCampaignsWidget extends StatelessWidget {
  const AllCampaignsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetWithDefaultHorizontalPadding(
      child: BlocConsumer<CampaignsCubit, CampaignsState>(
        listener: (context, state) {
          if (state is CampaignsLoaded) {
            context
                .read<LatestCampaignsCubit>()
                .getLatestCampaigns(campaigns: state.campaigns);
          } else if (state is CampaignsLoadingFailure) {
            context
                .read<LatestCampaignsCubit>()
                .emit(LatestCampaignsFailure(message: state.message));
          }
        },
        builder: (context, state) {
          if (state is CampaignsLoaded) {
            return BlocBuilder<LatestCampaignsCubit, LatestCampaignsState>(
                builder: (context, latestCampaignsState) {
              if (latestCampaignsState is LatestCampaignsLoaded) {
                return Loaded(
                  campaigns: latestCampaignsState.campaigns,
                );
              } else if (latestCampaignsState is LatestCampaignsEmpty) {
                return Empty();
              } else if (latestCampaignsState is LatestCampaignsFailure) {
                return Error(
                  message: latestCampaignsState.message,
                );
              } else {
                return SizedBox.shrink();
              }
            });
          } else if (state is CampaignsLoading) {
            return Loading();
          } else {
            // TODO: Handle if state is CampaignsLoadingFailure
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
