import 'package:flutter/material.dart';

import '../../../../../../../../core/config/custom_text_style.dart';
import '../../../../../../../../core/config/size_config.dart';
import '../../../../../../../widgets/widget_with_default_horizontal_padding.dart';
import '../../view_all_widget.dart';
import '../widgets/wallet_address_card.dart';

class Loaded extends StatelessWidget {
  const Loaded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetWithDefaultHorizontalPadding(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Campaign by Wallet Addresses",
                style: CustomTextStyle.blackTextStyle.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ViewAllWidget(
                onTap: () => _showAllWalletAddressesBottomSheet(context),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [0, 1, 2, 3, 4, 5]
                .asMap()
                .map(
                  (key, value) => MapEntry(
                    key,
                    Padding(
                      padding: EdgeInsets.only(
                        left: (key == 0) ? SizeConfig.defaultMargin : 15,
                        right: (key == 5) ? SizeConfig.defaultMargin : 0,
                      ),
                      child: GestureDetector(
                        onTap: _openAllCampaignsByWalletAddressScreen,
                        child: WalletAddressCard(),
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
          ),
        ),
      ],
    );
  }

  void _openAllCampaignsByWalletAddressScreen() {
    // TODO => Navigator to All Campaigns By Wallet Address Screen
  }

  void _showAllWalletAddressesBottomSheet(BuildContext context) {
    // TODO => Show All Wallet Addresses bottom sheet
  }
}
