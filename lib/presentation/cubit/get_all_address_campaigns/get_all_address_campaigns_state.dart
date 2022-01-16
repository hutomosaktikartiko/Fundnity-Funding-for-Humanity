part of 'get_all_address_campaigns_cubit.dart';

abstract class GetAllAddressCampaignsState extends Equatable {
  const GetAllAddressCampaignsState();

  @override
  List<Object?> get props => [];
}

class GetAllAddressCampaignsInitial extends GetAllAddressCampaignsState {}

class GetAllAddressCampaignsLoaded extends GetAllAddressCampaignsState {
  final List listAddressCampaigns;

  GetAllAddressCampaignsLoaded({required this.listAddressCampaigns});

  @override
  List<Object?> get props => [listAddressCampaigns];
}

class GetAllAddressCampaignsLoadingFailure extends GetAllAddressCampaignsState {
  final String? message;

  GetAllAddressCampaignsLoadingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}