import 'package:flutter/material.dart';

import '../../../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../../../presentation/screens/create_campaign/create_campaign_screen.dart';
import '../../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../../shared/config/size_config.dart';
import '../../../../../../../../shared/widgets/button/custom_button_label.dart';
import '../../../../../../../../shared/widgets/show_svg/show_svg_asset.dart';

class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultMargin * 3,
        ),
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.25,
          ),
          ShowSvgAsset(
            assetUrl: "assets/images/empty.svg",
            width: SizeConfig.screenWidth * 0.7,
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "Fundraising for everyone in need!",
              textAlign: TextAlign.center,
              style: CustomTextStyle.gray2TextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "Here are millions of #goodpeople who donate to all kinds of fundraisers very day.",
              textAlign: TextAlign.center,
              style: CustomTextStyle.gray2TextStyle.copyWith(
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          CustomButtonLabel(
            label: "Create Campaign",
            onTap: () => _onCreateCampaign(context),
          ),
        ],
      ),
    );
  }

  void _onCreateCampaign(BuildContext context) {
    ScreenNavigator.startScreen(context, CreateCampaignScreen());
  }
}
