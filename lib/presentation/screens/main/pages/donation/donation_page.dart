import 'package:flutter/material.dart';

import '../../../../../shared/widgets/custom_app_bar_with_search_form.dart';
import '../../../../../shared/widgets/widget_with_default_horizontal_padding.dart';
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
