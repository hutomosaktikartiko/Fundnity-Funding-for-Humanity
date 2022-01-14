part of 'get_all_campaigns_cubit.dart';

abstract class GetAllCampaignsState extends Equatable {
  const GetAllCampaignsState();

  @override
  List<Object?> get props => [];
}

class GetAllCampaignsInitial extends GetAllCampaignsState {}

class GetAllCampaignsLoaded extends GetAllCampaignsState {
  final List<dynamic>? listCampaigns;

  GetAllCampaignsLoaded({
    required this.listCampaigns
  });

  @override
  List<Object?> get props => [listCampaigns];
}

class GetAllCampaignsLoadingFailure extends GetAllCampaignsState {
  final String? message;

  GetAllCampaignsLoadingFailure({
    required this.message
  });

  @override
  List<Object?> get props => [message];
}