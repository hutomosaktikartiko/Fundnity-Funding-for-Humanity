part of 'my_campaigns_cubit.dart';

abstract class MyCampaignsState extends Equatable {
  const MyCampaignsState();

  @override
  List<Object?> get props => [];
}

class MyCampaignsInitial extends MyCampaignsState {}

class MyCampaignsLoading extends MyCampaignsState {}

class MyCampaignsLoaded extends MyCampaignsState {
  final List<CampaignFirestoreModel?> campaigns;

  const MyCampaignsLoaded({
    required this.campaigns,
  });

  @override
  List<Object?> get props => [campaigns];
}

class MyCampaignsEmpty extends MyCampaignsState {}

class MyCampaignsLoadingFailure extends MyCampaignsState {
  final String? message;

  const MyCampaignsLoadingFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
