part of 'all_campaigns_cubit.dart';

abstract class AllCampaignsState extends Equatable {
  const AllCampaignsState();

  @override
  List<Object?> get props => [];
}

class AllCampaignsInitial extends AllCampaignsState {}

class AllCampaignsEmpty extends AllCampaignsState {}

class AllCampaignsLoaded extends AllCampaignsState {
  final List<CampaignModel> campaigns;

  AllCampaignsLoaded({
    required this.campaigns,
  });

  @override
  List<Object?> get props => [];
}

class AllCampaignsFailure extends AllCampaignsState {
  final String message;

  AllCampaignsFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}