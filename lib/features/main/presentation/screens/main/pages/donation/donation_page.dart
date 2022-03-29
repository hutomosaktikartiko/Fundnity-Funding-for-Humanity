import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../service_locator.dart';
import '../../../../../../../shared/config/keys_config.dart';
import '../../../../../../../shared/config/urls_config.dart';
import '../../../../../../../shared/widgets/custom_app_bar_with_search_form.dart';
import '../../../../../../../shared/widgets/widget_with_default_horizontal_padding.dart';
import '../../../../cubit/campaigns/campaigns_cubit.dart';
import '../../../../cubit/crowdfunding_deployed_contract/crowdfunding_deployed_contract_cubit.dart';
import 'widgets/all_campaigns/all_campaigns_widget.dart';
import 'widgets/balance/balance_widget.dart';
import 'widgets/campaign_by_wallet_address/campaign_by_wallet_address_widget.dart';
import 'widgets/main_campaign/main_campaign_widget.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  @override
  void initState() {
    super.initState();
    _getCampaigns();
  }

  void _getCampaigns() {
    context.read<CampaignsCubit>().getCampaigns(
        web3Client: Web3Client(
            UrlsConfig.infuraRinkbeyProvider +
                KeysConfig.infuraEthereumProjectId,
            sl<Client>()),
        crowdfundindContract: (context
                .read<CrowdfundingDeployedContractCubit>()
                .state as CrowdfundingDeployedContractLoaded)
            .deployedContract);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithSearchForm(
        formHintText: "Type Children, Health, etc...",
        openSearchScreen: _openSearchScreen,
      ).build(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
}
