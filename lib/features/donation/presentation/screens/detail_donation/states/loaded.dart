import 'package:flutter/material.dart';

import '../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../shared/config/custom_color.dart';
import '../../../../../../shared/config/size_config.dart';
import '../../../../../../shared/widgets/button/custom_button_label.dart';
import '../../fill_donation_amount/fill_donation_amount_screen.dart';
import '../widgets/detail_donation_body_widget.dart';
import '../widgets/detail_donation_header.dart';
import '../widgets/detail_donation_sliver_header_delegate.dart';
import '../widgets/donation_history/donation_history_widget.dart';

class Loaded extends StatelessWidget {
  const Loaded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor.bgGray,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: DetailDonationSliverHeaderDelegate(
              collapsedHeight: 50,
              imageUrl: "imageUrl",
              expandedHeight: 200,
              title:
                  "Help Avisa to Continue Her College Study on Stanford University",
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                DetailDonationHeader(),
                const SizedBox(
                  height: 10,
                ),
                DetailDonationBody(),
                const SizedBox(
                  height: 10,
                ),
                DonationHistoryWidget(),
              ],
            ),
          ),
        ],
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
    ScreenNavigator.startScreen(context, FillDonationAmount());
  }
}
