part of 'recommended_campaign_cubit.dart';

abstract class RecommendedCampaignState extends Equatable {
  const RecommendedCampaignState();

  @override
  List<Object?> get props => [];
}

class RecommendedCampaignInitial extends RecommendedCampaignState {}

class RecommendedCampaignLoaded extends RecommendedCampaignState {
  final List<CampaignModel> campaigns;

  RecommendedCampaignLoaded({required this.campaigns});

  @override
  List<Object?> get props => [campaigns];
}

class RecommendedCampaignEmpty extends RecommendedCampaignState {}