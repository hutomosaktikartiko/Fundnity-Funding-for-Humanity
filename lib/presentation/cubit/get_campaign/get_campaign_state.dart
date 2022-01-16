part of 'get_campaign_cubit.dart';

abstract class GetCampaignState extends Equatable {
  const GetCampaignState();

  @override
  List<Object?> get props => [];
}

class GetCampaignInitial extends GetCampaignState {}

class GetCampaignLoaded extends GetCampaignState {
  final CampaignModel campaign;

  GetCampaignLoaded({required this.campaign});

  @override
  List<Object?> get props => [campaign];
}

class GetCampaignLoadingFailure extends GetCampaignState {
  final String? message;

  GetCampaignLoadingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
