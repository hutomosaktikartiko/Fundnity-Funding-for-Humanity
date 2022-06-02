import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../main/data/models/campaign_model.dart';

part 'recommended_campaign_state.dart';

class RecommendedCampaignCubit extends Cubit<RecommendedCampaignState> {
  RecommendedCampaignCubit() : super(RecommendedCampaignInitial());

  void getRecommendedCampaigns({
    required List<CampaignModel> campaigns,
  }) {
    final List<CampaignModel> _campaigns = List.from(campaigns);

    // Randomly sort the campaigns
    _campaigns..shuffle();

    if (campaigns.isEmpty) {
      emit(RecommendedCampaignEmpty());
    } else {
      // Just save 5 campaigns
      emit(RecommendedCampaignLoaded(campaigns: _campaigns.take(5).toList()));
    }
  }

  void getSearchCampaigns({
    required String keyword,
  }) {
    if (this.state is RecommendedCampaignLoaded) {
      final List<CampaignModel> _campaigns =
          (this.state as RecommendedCampaignLoaded)
              .campaigns
              .where((element) => element.title?.contains(keyword) ?? false)
              .toList();

      if (_campaigns.isEmpty) {
        emit(RecommendedCampaignEmpty());
      } else {
        emit(RecommendedCampaignLoaded(campaigns: _campaigns));
      }
    }
  }
}
