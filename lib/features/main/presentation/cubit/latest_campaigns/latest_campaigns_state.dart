part of 'latest_campaigns_cubit.dart';

abstract class LatestCampaignsState extends Equatable {
  const LatestCampaignsState();

  @override
  List<Object?> get props => [];
}

class LatestCampaignsInitial extends LatestCampaignsState {}

class LatestCampaignsEmpty extends LatestCampaignsState {}

class LatestCampaignsLoaded extends LatestCampaignsState {
  final List<CampaignModel> campaigns;

  LatestCampaignsLoaded({
    required this.campaigns,
  });

  @override
  List<Object?> get props => [];
}

class LatestCampaignsFailure extends LatestCampaignsState {
  final String message;

  LatestCampaignsFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}