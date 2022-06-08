import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/campaign_model.dart';

part 'main_campaign_state.dart';

class MainCampaignCubit extends Cubit<MainCampaignState> {
  MainCampaignCubit() : super(MainCampaignInitial());

  void getMainCampaigns({
    required List<CampaignModel> campaigns,
  }) {
    final List<CampaignModel> _campaigns = List.from(campaigns.where((element) => element.status == CampaignStatus.Active));
    
    _campaigns.sort((a, b) => (a.endDate ??
            BigInt.from(DateTime.now().millisecondsSinceEpoch))
        .compareTo(
            (b.endDate ?? BigInt.from(DateTime.now().millisecondsSinceEpoch))));

    if (campaigns.isEmpty) {
      emit(MainCampaignEmpty());
    } else {
      emit(MainCampaignLoaded(campaigns: _campaigns));
    }
  }
}
