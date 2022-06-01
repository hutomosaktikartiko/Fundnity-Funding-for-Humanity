import 'package:bloc/bloc.dart';

import '../../../data/models/campaign_model.dart';

part 'latest_campaigns_state.dart';

class LatestCampaignsCubit extends Cubit<LatestCampaignsState> {
  LatestCampaignsCubit() : super(LatestCampaignsInitial());

  void getLatestCampaigns({
    required List<CampaignModel> campaigns,
  }) {
    if (campaigns.length < 1) {
      emit(LatestCampaignsEmpty());
    } else {
      emit(LatestCampaignsLoaded(campaigns: List.from(campaigns.reversed)));
    }
  }
}
