import 'package:flutter/material.dart';

import '../../../../../core/utils/screen_navigator.dart';
import '../../../../../shared/config/custom_color.dart';
import '../../../../../shared/config/size_config.dart';
import '../../../../../shared/extension/string_parsing.dart';
import '../../../../../shared/widgets/button/custom_button_label.dart';
import '../../../../main/data/models/campaign_model.dart';
import '../fill_donation_amount/fill_donation_amount_screen.dart';
import 'widgets/detail_donation_body_widget.dart';
import 'widgets/detail_donation_header.dart';
import 'widgets/detail_donation_sliver_header_delegate.dart';
import 'widgets/donation_history/donation_history_widget.dart';

class DetailDonationScreen extends StatelessWidget {
  const DetailDonationScreen({
    Key? key,
    required this.campaign,
  }) : super(key: key);

  final CampaignModel? campaign;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor.bgGray,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: DetailDonationSliverHeaderDelegate(
                collapsedHeight: 50,
                imageUrl: campaign?.image.stringHashImageToImageUrl() ?? '',
                expandedHeight: 200,
                title: campaign?.title ?? "-",
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  DetailDonationHeader(
                    campaign: campaign,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DetailDonationBody(
                    campaign: campaign,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DonationHistoryWidget(
                    address: campaign?.address,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultMargin,
          vertical: SizeConfig.defaultMargin + 5,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Material(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: UniversalColor.green4,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: SizeConfig.defaultMargin,
                      ),
                      child: Icon(
                        Icons.share,
                        color: UniversalColor.green4,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomButtonLabel(
                    label: "Donate Now",
                    onTap: () => _onDonateNow(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onDonateNow(BuildContext context) {
    ScreenNavigator.startScreen(context, FillDonationAmount(
      campaign: campaign,
      address: campaign?.address,
    ));
  }
}
