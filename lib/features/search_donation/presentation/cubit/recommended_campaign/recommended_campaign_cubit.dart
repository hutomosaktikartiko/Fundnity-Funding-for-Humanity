import 'package:bloc/bloc.dart';

import '../../../../main/data/models/campaign_model.dart';

part 'recommended_campaign_state.dart';

class RecommendedCampaignCubit extends Cubit<RecommendedCampaignState> {
  RecommendedCampaignCubit() : super(RecommendedCampaignInitial());

  void getSearchCampaigns({
    required String keyword,
    required List<CampaignModel> campaigns,
  }) {
    // Create new variabel _activeCampaign from campaigns
    // where CampaignStatus is CampaignStatus.Active
    final List<CampaignModel> _activeCampaign = List.from(
        campaigns.where((element) => element.status == CampaignStatus.Active));

    // Searching campaigns in _activeCampaigns by keyword
    final List<CampaignModel> _campaigns = _activeCampaign
        .where((element) =>
            element.title?.toLowerCase().contains(keyword.toLowerCase()) ??
            false)
        .toList();

    // Check result of searching campaign
    if (_campaigns.isEmpty) {
      // Result is Empty
      getRecommendedCampaigns(campaigns: campaigns);
    } else {
      // Result available
      emit(RecommendedCampaignLoaded(
        campaigns: _campaigns,
      ));
    }
  }

  void getRecommendedCampaigns({
    required List<CampaignModel> campaigns,
  }) {
    // Create new variabel _campaigns from campaigns
    // where CampaignStatus is CampaignStatus.Active
    final List<CampaignModel> _campaigns = List.from(
        campaigns.where((element) => element.status == CampaignStatus.Active));

    // Randomly sort the campaigns
    _campaigns..shuffle();

    // Check result CampaignStatus is CampaignStatus.Active
    if (campaigns.isNotEmpty) {
      // Result is not empty
      // Result available
      // Just assign 5 campaigns
      emit(RecommendedCampaignEmpty(
        campaigns: _campaigns.take(5).toList(),
      ));
    }
  }
}
