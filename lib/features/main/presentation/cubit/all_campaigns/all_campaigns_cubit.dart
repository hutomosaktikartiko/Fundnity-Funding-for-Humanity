import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/campaign_model.dart';

part 'all_campaigns_state.dart';

class AllCampaignsCubit extends Cubit<AllCampaignsState> {
  AllCampaignsCubit() : super(AllCampaignsInitial());

  void getAllCampaigns({
    required List<CampaignModel> campaigns,
  }) {
    if (campaigns.length < 1) {
      emit(AllCampaignsEmpty());
    } else {
      emit(AllCampaignsLoaded(campaigns: campaigns));
    }
  }
}
