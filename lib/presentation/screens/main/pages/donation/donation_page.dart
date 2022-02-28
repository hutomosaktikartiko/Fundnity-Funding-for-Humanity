import 'package:flutter/material.dart';

import '../../../../widgets/widget_with_default_horizontal_padding.dart';
import 'widgets/all_campaigns/all_campaigns_widget.dart';
import 'widgets/balance/balance_widget.dart';
import 'widgets/campaign_by_wallet_address/campaign_by_wallet_address_widget.dart';
import 'widgets/donation_page_app_bar.dart';
import 'widgets/main_campaign/main_campaign_widget.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DonationPageAppBar().build(context),
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
}
