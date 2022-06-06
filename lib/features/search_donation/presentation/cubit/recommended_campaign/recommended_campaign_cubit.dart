import 'package:bloc/bloc.dart';

import '../../../../main/data/models/campaign_model.dart';

part 'recommended_campaign_state.dart';

class RecommendedCampaignCubit extends Cubit<RecommendedCampaignState> {
  RecommendedCampaignCubit() : super(RecommendedCampaignInitial());

  void getSearchCampaigns({
    required String keyword,
    required List<CampaignModel> campaigns,
  }) {
    final List<CampaignModel> _campaigns = campaigns
        .where((element) =>
            element.title?.toLowerCase().contains(keyword.toLowerCase()) ??
            false)
        .toList();

    if (_campaigns.isEmpty) {
      getRecommendedCampaigns(campaigns: campaigns);
    } else {
      emit(RecommendedCampaignLoaded(
        campaigns: _campaigns,
        isSearching: true,
      ));
    }
  }

  void getRecommendedCampaigns({
    required List<CampaignModel> campaigns,
  }) {
    final List<CampaignModel> _campaigns = List.from(campaigns);

    // Randomly sort the campaigns
    _campaigns..shuffle();

    if (campaigns.isEmpty) {
      emit(RecommendedCampaignEmpty());
    } else {
      // Just assign 5 campaigns
      emit(RecommendedCampaignLoaded(
        isSearching: false,
        campaigns: _campaigns.take(5).toList(),
      ));
    }
  }
}
