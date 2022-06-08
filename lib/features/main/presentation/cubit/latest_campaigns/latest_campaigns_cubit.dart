import 'package:bloc/bloc.dart';

import '../../../data/models/campaign_model.dart';

part 'latest_campaigns_state.dart';

class LatestCampaignsCubit extends Cubit<LatestCampaignsState> {
  LatestCampaignsCubit() : super(LatestCampaignsInitial());

  void getLatestCampaigns({
    required List<CampaignModel> campaigns,
  }) {
    final List<CampaignModel> _campaigns = List.from(campaigns.where((element) => element.status == CampaignStatus.Active).toList().reversed);
    if (_campaigns.length < 1) {
      emit(LatestCampaignsEmpty());
    } else {
      emit(LatestCampaignsLoaded(campaigns: _campaigns));
    }
  }
}
