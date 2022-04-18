part of 'selected_filter_campaign_cubit.dart';

class SelectedFilterCampaignState extends Equatable {
  final FilterModel? filter;

  SelectedFilterCampaignState({
    required this.filter,
  });

  @override
  List<Object?> get props => [filter];
}
