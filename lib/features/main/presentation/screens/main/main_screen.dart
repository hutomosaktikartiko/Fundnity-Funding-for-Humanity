import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/widgets/custom_box_shadow.dart';
import '../../../../auth/presentation/cubit/wallet/wallet_cubit.dart';
import '../../../data/models/tab_model.dart';
import '../../cubit/account_balance/account_balance_cubit.dart';
import '../../cubit/campaigns/campaigns_cubit.dart';
import '../../cubit/crowdfunding_deployed_contract/crowdfunding_deployed_contract_cubit.dart';
import '../../cubit/history/history_cubit.dart';
import '../../cubit/web3client/web3client_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    _getCampaigns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: mockListTabsMain[currentTab].widget,
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
    return Container(
      decoration:
          BoxDecoration(boxShadow: [CustomBoxShadow.defaultBoxShadow()]),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        child: BottomNavigationBar(
          currentIndex: currentTab,
          onTap: _moveTab,
          items: mockListTabsMain
              .map(
                (tab) => BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Icon(tab.iconData),
                  ),
                  label: tab.label,
                ),
              )
              .toList(),
          selectedFontSize: 10,
          unselectedFontSize: 10,
          iconSize: 18,
        ),
      ),
    );
  }

  void _moveTab(int index) {
    // Check index
    if (index == 0) {
      // DonationPage
      _getBalance();
      _getCampaigns();
    } else if (index == 1) {
      // My Campaign Page
      _getCampaigns();
    } else if (index == 2) {
      // Get Hisory
      _getHistory();
    }
    setState(() => currentTab = index);
  }

  // TODO => Tambah animation ketika tab tekan dari nonaktif menjadi aktif
  // TODO => Perubahan icon tab ketika aktif

  void _getBalance() {
    if (context.read<WalletCubit>().state is WalletLoaded) {
      context.read<AccountBalanceCubit>().getBalance(
            address: (context.read<WalletCubit>().state as WalletLoaded)
                .wallet
                .privateKey
                .address,
            web3Client: context.read<Web3ClientCubit>().state.web3client,
          );
    }
  }

  void _getCampaigns() {
    context.read<CampaignsCubit>().getCampaigns(
          web3Client: context.read<Web3ClientCubit>().state.web3client,
          crowdfundindContract: (context
                  .read<CrowdfundingDeployedContractCubit>()
                  .state as CrowdfundingDeployedContractLoaded)
              .deployedContract,
        );
  }

  void _getHistory() {
    if (context.read<WalletCubit>().state is WalletLoaded) {
      context.read<HistoryCubit>().getListHistory(
          address: (context.read<WalletCubit>().state as WalletLoaded)
              .wallet
              .privateKey
              .address
              .hex);
    }
  }
}
