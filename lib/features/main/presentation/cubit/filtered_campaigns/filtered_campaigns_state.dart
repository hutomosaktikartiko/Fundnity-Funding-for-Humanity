part of 'filtered_campaigns_cubit.dart';

class FilteredCampaignsState extends Equatable {
  FilteredCampaignsState({
    required this.campaigns,
  });

  List<CampaignModel?> campaigns;

  @override
  List<Object> get props => [campaigns];
}
