import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../data/models/campaign_model.dart';

part 'campaign_by_wallet_addresses_state.dart';

class CampaignByWalletAddressesCubit extends Cubit<CampaignByWalletAddressesState> {
  CampaignByWalletAddressesCubit() : super(CampaignByWalletAddressesInitial());

  void getCampaignByWalletAddresses({
    required List<CampaignModel> campaigns,
  }) {
    if (campaigns.length < 1) {
      emit(CampaignByWalletAddressesEmpty());
    } else {
      Map<EthereumAddress?, List<CampaignModel>> result = groupBy(campaigns, (CampaignModel campaign) => campaign.creatorAddress);
      emit(CampaignsByWalletAddressesLoaded(addresses: result.keys.toList()));
    }
  }
}
