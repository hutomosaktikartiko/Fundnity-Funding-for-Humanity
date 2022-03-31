import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/campaign_model.dart';

part 'main_campaign_state.dart';

class MainCampaignCubit extends Cubit<MainCampaignState> {
  MainCampaignCubit() : super(MainCampaignInitial());

  void getMainCampaigns({
    required List<CampaignModel> campaigns,
  }) {
    // TODO: Add endDate validation
    final List<CampaignModel> _campaigns = campaigns.where((element) => element.isComplete == false).toList();

    if (campaigns.isEmpty) {
      emit(MainCampaignEmpty());
    } else {
      emit(MainCampaignLoaded(campaigns: _campaigns));
    }
  }
}
