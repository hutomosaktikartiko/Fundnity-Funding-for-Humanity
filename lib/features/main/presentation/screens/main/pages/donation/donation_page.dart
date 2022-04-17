import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../shared/widgets/custom_app_bar_with_search_form.dart';
import '../../../../../../../shared/widgets/widget_with_default_horizontal_padding.dart';
import '../../../../../../auth/presentation/cubit/wallet/wallet_cubit.dart';
import '../../../../cubit/account_balance/account_balance_cubit.dart';
import '../../../../cubit/campaigns/campaigns_cubit.dart';
import '../../../../cubit/crowdfunding_deployed_contract/crowdfunding_deployed_contract_cubit.dart';
import '../../../../cubit/web3client/web3client_cubit.dart';
import 'widgets/all_campaigns/all_campaigns_widget.dart';
import 'widgets/balance/balance_widget.dart';
import 'widgets/campaign_by_wallet_address/campaign_by_wallet_address_widget.dart';
import 'widgets/main_campaign/main_campaign_widget.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithSearchForm(
        formHintText: "Type Children, Health, etc...",
        openSearchScreen: _openSearchScreen,
      ).build(context),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            WidgetWithDefaultHorizontalPadding(
              child: BalanceWidget(),
            ),
            MainCampaignWidget(),
            CampaignByWalletAddressWidget(),
            AllCampaignsWidget(),
          ],
        ),
      ),
    );
  }

  void _openSearchScreen() {
    // TODO => Navigator to search screen
  }

  Future<void> _onRefresh(BuildContext context) async {
    _getBalance(context);
    _getCampaigns(context);
  }

  Future<void> _getBalance(BuildContext context) async {
    await context.read<AccountBalanceCubit>().getBalance(
          address: (context.read<WalletCubit>().state as WalletLoaded)
              .wallet
              .privateKey
              .address,
          web3Client: context.read<Web3ClientCubit>().state.web3client,
        );
  }

  Future<void> _getCampaigns(BuildContext context) async {
    await context.read<CampaignsCubit>().getCampaigns(
          web3Client: context.read<Web3ClientCubit>().state.web3client,
          crowdfundindContract: (context
                  .read<CrowdfundingDeployedContractCubit>()
                  .state as CrowdfundingDeployedContractLoaded)
              .deployedContract,
        );
  }
}
