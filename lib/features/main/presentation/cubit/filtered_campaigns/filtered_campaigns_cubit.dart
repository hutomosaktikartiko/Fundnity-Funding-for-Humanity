import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/campaign_model.dart';

part 'filtered_campaigns_state.dart';

class FilteredCampaignsCubit extends Cubit<FilteredCampaignsState> {
  FilteredCampaignsCubit() : super(FilteredCampaignsState(campaigns: []));

  void setFilteredCampaigns({
    required List<CampaignModel?> campaigns,
    required String? filter,
  }) {
    if (filter == null || filter == 'All') {
      setDefaultFilteredCampaigns(campaigns: campaigns);

      return;
    }
    final List<CampaignModel?> results = campaigns.where((element) => element?.status.toString().split('.').last == filter).toList();
    emit(FilteredCampaignsState(campaigns: results));
  }

  void setDefaultFilteredCampaigns({
    required List<CampaignModel?> campaigns,
  }) {
    emit(FilteredCampaignsState(campaigns: campaigns));
  }
}
