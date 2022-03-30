import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../cubit/campaign_by_wallet_addresses/campaign_by_wallet_addresses_cubit.dart';
import '../../../../../../cubit/campaigns/campaigns_cubit.dart';
import 'states/empty.dart';
import 'states/error.dart';
import 'states/loaded.dart';
import 'states/loading.dart';

class CampaignByWalletAddressWidget extends StatelessWidget {
  const CampaignByWalletAddressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CampaignsCubit, CampaignsState>(
      listener: (context, state) {
        if (state is CampaignsLoaded) {
          context
              .read<CampaignByWalletAddressesCubit>()
              .getCampaignByWalletAddresses(campaigns: state.campaigns);
        } else if (state is CampaignsLoadingFailure) {
          context.read<CampaignByWalletAddressesCubit>().emit(
              CampaignByWalletAddressesLoadingFailure(message: state.message));
        }
      },
      builder: (context, state) {
        if (state is CampaignsLoaded) {
          return BlocBuilder<CampaignByWalletAddressesCubit,
              CampaignByWalletAddressesState>(
            builder: (context, campaignByWalletAddressesState) {
              if (campaignByWalletAddressesState
                  is CampaignsByWalletAddressesLoaded) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Loaded(
                    addresses: campaignByWalletAddressesState.addresses,
                  ),
                );
              } else if (campaignByWalletAddressesState
                  is CampaignByWalletAddressesEmpty) {
                return Empty();
              } else if (campaignByWalletAddressesState
                  is CampaignByWalletAddressesLoadingFailure) {
                return Error(message: campaignByWalletAddressesState.message);
              } else {
                return SizedBox.shrink();
              }
            },
          );
        } else if (state is CampaignsLoading) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Loading(),
          );
        } else {
          // TODO: Handle if state is CampaignsLoadingFailure
          return SizedBox.shrink();
        }
      },
    );
  }
}
