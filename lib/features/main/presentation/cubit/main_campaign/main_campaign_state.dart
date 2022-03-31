part of 'main_campaign_cubit.dart';

abstract class MainCampaignState extends Equatable {
  const MainCampaignState();

  @override
  List<Object?> get props => [];
}

class MainCampaignInitial extends MainCampaignState {}

class MainCampaignLoaded extends MainCampaignState {
  final List<CampaignModel> campaigns;

  MainCampaignLoaded({required this.campaigns});

  @override
  List<Object?> get props => [campaigns];
}

class MainCampaignEmpty extends MainCampaignState {}

class MainCampaignLoadingFailure extends MainCampaignState {
  final String message;

  MainCampaignLoadingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}