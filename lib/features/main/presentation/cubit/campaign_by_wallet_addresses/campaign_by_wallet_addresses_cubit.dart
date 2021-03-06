import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../data/models/campaign_model.dart';

part 'campaign_by_wallet_addresses_state.dart';

class CampaignByWalletAddressesCubit
    extends Cubit<CampaignByWalletAddressesState> {
  CampaignByWalletAddressesCubit() : super(CampaignByWalletAddressesInitial());

  void getCampaignByWalletAddresses({
    required List<CampaignModel> campaigns,
  }) {
    final List<CampaignModel> _campaigns = List.from(campaigns.where((element) => element.status == CampaignStatus.Active));

    if (_campaigns.length < 1) {
      emit(CampaignByWalletAddressesEmpty());
    } else {
      Map<EthereumAddress?, List<CampaignModel>> result = groupBy(
          _campaigns, (CampaignModel campaign) => campaign.creatorAddress);
      emit(CampaignsByWalletAddressesLoaded(addresses: result.keys.toList()));
    }
  }

  List<CampaignModel>? getCampaigns({
    required String? walletAddress,
    required List<CampaignModel> campaigns,
  }) {
    if (walletAddress == null) return null;

    return campaigns
        .where((element) => element.creatorAddress.toString() == walletAddress)
        .toList();
  }
}
