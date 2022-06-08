import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../auth/presentation/cubit/wallet/wallet_cubit.dart';
import '../../../../cubit/my_campaigns/my_campaigns_cubit.dart';
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
            return BlocBuilder<MyCampaignsCubit, MyCampaignsState>(
              builder: (context, myCampaignsState) {
                if (myCampaignsState is MyCampaignsLoaded) {
                  return Loaded(
                    campaigns: myCampaignsState.campaigns,
                  );
                } else if (myCampaignsState is MyCampaignsEmpty) {
                  return Empty();
                } else if (myCampaignsState is MyCampaignsLoadingFailure) {
                  return Error(
                    message: myCampaignsState.message,
                  );
                }

                return Loading();
              },
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
