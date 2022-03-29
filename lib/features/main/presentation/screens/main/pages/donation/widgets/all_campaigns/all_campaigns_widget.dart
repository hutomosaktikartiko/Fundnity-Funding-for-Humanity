import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../shared/widgets/widget_with_default_horizontal_padding.dart';
import '../../../../../../cubit/all_campaigns/all_campaigns_cubit.dart';
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
                .read<AllCampaignsCubit>()
                .getAllCampaigns(campaigns: state.campaigns);
          } else if (state is CampaignsLoadingFailure) {
            context
                .read<AllCampaignsCubit>()
                .emit(AllCampaignsFailure(message: state.message));
          }
        },
        builder: (context, state) {
          if (state is CampaignsLoaded) {
            return BlocBuilder<AllCampaignsCubit, AllCampaignsState>(
                builder: (context, allCampaignsState) {
              if (allCampaignsState is AllCampaignsLoaded) {
                return Loaded(
                  campaigns: allCampaignsState.campaigns,
                );
              } else if (allCampaignsState is AllCampaignsEmpty) {
                return Empty();
              } else if (allCampaignsState is AllCampaignsFailure) {
                return Error(
                  message: allCampaignsState.message,
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
