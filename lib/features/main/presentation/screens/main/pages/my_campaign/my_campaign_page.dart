import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../auth/presentation/cubit/wallet/wallet_cubit.dart';
import '../../../../../data/models/campaign_model.dart';
import '../../../../cubit/campaigns/campaigns_cubit.dart';
import '../../../../cubit/my_campaigns/my_campaigns_cubit.dart';
import '../../../../cubit/web3client/web3client_cubit.dart';
import 'states/empty.dart';
import 'states/error.dart';
import 'states/loaded.dart';
import 'states/loading.dart';

class MyCampaignPage extends StatelessWidget {
  const MyCampaignPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, walletState) {
          if (walletState is WalletLoaded) {
            return BlocConsumer<CampaignsCubit, CampaignsState>(
              listener: (context, campaignsState) {
                if (campaignsState is CampaignsLoaded) {
                  _campaignsLoaded(
                    context: context,
                    campaigns: campaignsState.campaigns,
                    address: walletState.wallet.privateKey.address,
                  );
                } else if (campaignsState is CampaignsEmpty) {
                  _campaignsEmpty(
                    context: context,
                    address: walletState.wallet.privateKey.address,
                  );
                } else if (campaignsState is CampaignsLoadingFailure) {
                  _campaignsLoadingFailure(
                    context: context,
                    message: campaignsState.message,
                  );
                }
              },
              builder: (context, campaignsState) {
                if (campaignsState is CampaignsLoaded ||
                    campaignsState is CampaignsEmpty) {
                  return BlocBuilder<MyCampaignsCubit, MyCampaignsState>(
                    builder: (context, myCampaignsState) {
                      if (myCampaignsState is MyCampaignsLoaded) {
                        return Loaded(
                          campaigns: myCampaignsState.campaigns,
                        );
                      } else if (myCampaignsState is MyCampaignsEmpty) {
                        return Empty();
                      } else if (myCampaignsState is MyCampaignsLoading) {
                        return Loading();
                      } else if (myCampaignsState
                          is MyCampaignsLoadingFailure) {
                        return Error(
                          message: myCampaignsState.message,
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  );
                } else if (campaignsState is CampaignsLoading) {
                  return Loading();
                } else {
                  return SizedBox.shrink();
                }
              },
            );
          }

          // Not login
          // TODO: Not login UI
          return SizedBox.shrink();
        },
      ),
    );
  }

  void _campaignsLoaded({
    required BuildContext context,
    required List<CampaignModel> campaigns,
    required EthereumAddress? address,
  }) {
    context.read<MyCampaignsCubit>().getMyCampaigns(
          campaigns: campaigns,
          web3Client: context.read<Web3ClientCubit>().state.web3client,
          address: address,
        );
  }

  void _campaignsEmpty({
    required BuildContext context,
    required EthereumAddress? address,
  }) {
    context.read<MyCampaignsCubit>().getMyCampaigns(
      campaigns: [],
      web3Client: context.read<Web3ClientCubit>().state.web3client,
      address: address,
    );
  }

  void _campaignsLoadingFailure({
    required BuildContext context,
    required String message,
  }) {
    context
        .read<MyCampaignsCubit>()
        .emit(MyCampaignsLoadingFailure(message: message));
  }
}
