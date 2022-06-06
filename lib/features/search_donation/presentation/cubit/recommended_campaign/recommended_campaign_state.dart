part of 'recommended_campaign_cubit.dart';

abstract class RecommendedCampaignState {
  const RecommendedCampaignState();
}

class RecommendedCampaignInitial extends RecommendedCampaignState {}

class RecommendedCampaignLoaded extends RecommendedCampaignState {
  final List<CampaignModel> campaigns;
  final bool isSearching;

  RecommendedCampaignLoaded({
    required this.campaigns,
    this.isSearching = false,
  });
}

class RecommendedCampaignEmpty extends RecommendedCampaignState {}
