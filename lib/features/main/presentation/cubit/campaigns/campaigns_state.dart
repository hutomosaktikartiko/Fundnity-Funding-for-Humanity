part of 'campaigns_cubit.dart';

abstract class CampaignsState extends Equatable {
  const CampaignsState();

  @override
  List<Object?> get props => [];
}

class CampaignsInitial extends CampaignsState {}

class CampaignsLoading extends CampaignsState {}

class CampaignsLoaded extends CampaignsState {
  final List<CampaignModel> campaigns;

  CampaignsLoaded({
    required this.campaigns,
  });

  @override
  List<Object?> get props => [];
}

class CampaignsLoadingFailure extends CampaignsState {
  final String message;

  CampaignsLoadingFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
