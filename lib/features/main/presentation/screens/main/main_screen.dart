import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../service_locator.dart';
import '../../../../../shared/config/keys_config.dart';
import '../../../../../shared/config/urls_config.dart';
import '../../../../../shared/widgets/custom_box_shadow.dart';
import '../../../data/models/tab_model.dart';
import '../../cubit/campaigns/campaigns_cubit.dart';
import '../../cubit/crowdfunding_deployed_contract/crowdfunding_deployed_contract_cubit.dart';

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
      body: mockListTabModel[currentTab].widget,
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
          items: mockListTabModel
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
    if (index == 0 || index == 1) {
      // DonationPage || MyCampaignPage
      _getCampaigns();
    }
    setState(() => currentTab = index);
  }

  // TODO => Tambah animation ketika tab tekan dari nonaktif menjadi aktif
  // TODO => Perubahan icon tab ketika aktif

  void _getCampaigns() {
    context.read<CampaignsCubit>().getCampaigns(
          web3Client: Web3Client(
              UrlsConfig.infuraRinkbeyProvider +
                  KeysConfig.infuraEthereumProjectId,
              sl<Client>()),
          crowdfundindContract: (context
                  .read<CrowdfundingDeployedContractCubit>()
                  .state as CrowdfundingDeployedContractLoaded)
              .deployedContract,
        );
  }
}
