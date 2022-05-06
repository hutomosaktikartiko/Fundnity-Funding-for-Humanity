part of 'latest_campaigns_cubit.dart';

abstract class LatestCampaignsState {
  const LatestCampaignsState();
}

class LatestCampaignsInitial extends LatestCampaignsState {}

class LatestCampaignsEmpty extends LatestCampaignsState {}

class LatestCampaignsLoaded extends LatestCampaignsState {
  final List<CampaignModel> campaigns;

  LatestCampaignsLoaded({
    required this.campaigns,
  });
}

class LatestCampaignsFailure extends LatestCampaignsState {
  final String message;

  LatestCampaignsFailure({
    required this.message,
  });
}