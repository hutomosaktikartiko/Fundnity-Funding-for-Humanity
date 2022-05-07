import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../auth/presentation/cubit/wallet/wallet_cubit.dart';
import '../../../../cubit/campaigns/campaigns_cubit.dart';
import '../../../../cubit/my_campaigns/my_campaigns_cubit.dart';
import '../../../../cubit/web3client/web3client_cubit.dart';
import 'states/empty.dart';
import 'states/error.dart';
import 'states/loaded.dart';
import 'states/loading.dart';

class MyCampaignPage extends StatefulWidget {
  const MyCampaignPage({Key? key}) : super(key: key);

  @override
  _MyCampaignPageState createState() => _MyCampaignPageState();
}

class _MyCampaignPageState extends State<MyCampaignPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<CampaignsCubit, CampaignsState>(
        listener: (context, state) {
          if (state is CampaignsLoaded) {
            context.read<MyCampaignsCubit>().getMyCampaigns(
                  campaigns: state.campaigns,
                  web3Client: context.read<Web3ClientCubit>().state.web3client,
                  address: (context.read<WalletCubit>().state as WalletLoaded)
                      .wallet
                      .privateKey
                      .address,
                );
          } else if (state is CampaignsEmpty) {
            context.read<MyCampaignsCubit>().getMyCampaigns(
              campaigns: [],
              web3Client: context.read<Web3ClientCubit>().state.web3client,
              address: (context.read<WalletCubit>().state as WalletLoaded)
                  .wallet
                  .privateKey
                  .address,
            );
          } else if (state is CampaignsLoadingFailure) {
            context
                .read<MyCampaignsCubit>()
                .emit(MyCampaignsLoadingFailure(message: state.message));
          }
        },
        builder: (context, state) {
          if (state is CampaignsLoaded || state is CampaignsEmpty) {
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
                } else if (myCampaignsState is MyCampaignsLoadingFailure) {
                  return Error(
                    message: myCampaignsState.message,
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            );
          } else if (state is CampaignsLoading) {
            return Loading();
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
