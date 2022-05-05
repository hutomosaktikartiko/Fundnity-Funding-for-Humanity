import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../../../../shared/config/size_config.dart';
import '../../../../../../../../../../shared/extension/string_parsing.dart';
import '../../../../../../../../../../shared/widgets/widget_with_default_horizontal_padding.dart';
import '../../../../../../../../data/models/campaign_model.dart';
import '../../../../../../../cubit/campaign_by_wallet_addresses/campaign_by_wallet_addresses_cubit.dart';
import '../../../../../../../cubit/campaigns/campaigns_cubit.dart';
import '../../../../../../all_campaigns/all_campaigns_screen.dart';
import '../../view_all_widget.dart';
import '../widgets/wallet_address_card.dart';

class Loaded extends StatelessWidget {
  const Loaded({
    Key? key,
    required this.addresses,
  }) : super(key: key);

  final List<EthereumAddress?> addresses;

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
          child: BlocBuilder<CampaignsCubit, CampaignsState>(
            builder: (context, state) {
              return Row(
                children: addresses
                    .asMap()
                    .map(
                      (key, address) => MapEntry(
                        key,
                        Padding(
                          padding: EdgeInsets.only(
                            left: (key == 0) ? SizeConfig.defaultMargin : 15,
                            right: (key == 5) ? SizeConfig.defaultMargin : 0,
                          ),
                          child: GestureDetector(
                            onTap: () => _openAllCampaignsByWalletAddressScreen(
                              context: context,
                              address: address,
                              campaigns: (state is CampaignsLoaded)
                                  ? state.campaigns
                                  : [],
                            ),
                            child: WalletAddressCard(
                              address: address,
                            ),
                          ),
                        ),
                      ),
                    )
                    .values
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  void _openAllCampaignsByWalletAddressScreen({
    required BuildContext context,
    required EthereumAddress? address,
    required List<CampaignModel> campaigns,
  }) {
    ScreenNavigator.startScreen(
      context,
      AllCampaignsScreen(
        campaigns: context.read<CampaignByWalletAddressesCubit>().getCampaigns(
              walletAddress: address.toString(),
              campaigns: campaigns,
            ),
        title: "Campaigns by ${address.toString().walletAddressSplit()}",
      ),
    );
  }

  void _showAllWalletAddressesBottomSheet(BuildContext context) {
    // TODO => Show All Wallet Addresses bottom sheet
  }
}
