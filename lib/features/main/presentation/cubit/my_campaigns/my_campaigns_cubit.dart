import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../data/models/campaign_model.dart';

part 'my_campaigns_state.dart';

class MyCampaignsCubit extends Cubit<MyCampaignsState> {
  MyCampaignsCubit() : super(MyCampaignsInitial());

  void getMyCampaigns({
    required List<CampaignModel> campaigns,
    required EthereumAddress myAddress,
  }) {
    final Map<EthereumAddress?, List<CampaignModel>> groupingCampaigns =
        groupBy(campaigns, (CampaignModel campaign) => campaign.creatorAddress);

    if (groupingCampaigns[myAddress] == null) {
      emit(MyCampaignsEmpty());
    } else {
      emit(MyCampaignsLoaded(campaigns: campaigns));
    }
  }
}
