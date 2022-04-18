import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/filter_model.dart';

part 'selected_filter_campaign_state.dart';

class SelectedFilterCampaignCubit extends Cubit<SelectedFilterCampaignState> {
  SelectedFilterCampaignCubit()
      : super(SelectedFilterCampaignState(
          filter: null,
        ));

  void setSelectedFilter({required FilterModel? filter}) {
    emit(SelectedFilterCampaignState(filter: filter));
  }

  void setDefaultFilter() {
    emit(SelectedFilterCampaignState(filter: mockListFiltersMyCampaigs.first));
  }
}
