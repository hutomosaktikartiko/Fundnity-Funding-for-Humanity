part of 'recommended_campaign_cubit.dart';

abstract class RecommendedCampaignState {
  const RecommendedCampaignState();
}

class RecommendedCampaignInitial extends RecommendedCampaignState {}

class RecommendedCampaignLoaded extends RecommendedCampaignState {
  final List<CampaignModel> campaigns;

  RecommendedCampaignLoaded({
    required this.campaigns,
  });
}

class RecommendedCampaignEmpty extends RecommendedCampaignState {
  final List<CampaignModel> campaigns;

  RecommendedCampaignEmpty({
    required this.campaigns,
  });
}

// class SearchingResult extends RecommendedCampaignState {
//   final List<CampaignModel> campaigns;

//   SearchingResult({
//     required this.campaigns,
//   });
// }
