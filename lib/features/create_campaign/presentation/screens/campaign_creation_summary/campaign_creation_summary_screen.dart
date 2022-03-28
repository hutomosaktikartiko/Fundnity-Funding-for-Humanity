import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/config/custom_color.dart';
import '../../../../../shared/config/custom_text_style.dart';
import '../../../../../shared/config/size_config.dart';
import '../../../../../shared/widgets/button/custom_button_label.dart';
import '../../cubit/create_campaign_target_data/create_campaign_data_cubit.dart';
import 'widgets/description_widget.dart';
import 'widgets/target_widget.dart';
import 'widgets/title_widget.dart';

class CampaignCreationSummary extends StatelessWidget {
  const CampaignCreationSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Campaign Creation Summary',
          style: CustomTextStyle.whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<CreateCampaignDataCubit, CreateCampaignDataState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultMargin,
            ),
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Review your campaign information",
                style: CustomTextStyle.gray2TextStyle.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "The following is the campaign information that you have filled",
                style: CustomTextStyle.gray2TextStyle.copyWith(
                  fontSize: 10,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TargetWidget(
                amount: state.amount,
                time: state.time,
              ),
              const SizedBox(
                height: 15,
              ),
              TitleWidget(
                image: state.image,
                title: state.title,
              ),
              const SizedBox(
                height: 15,
              ),
              DescriptionWidget(
                description: state.description,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        color: BackgroundColor.bgGray,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultMargin,
          vertical: SizeConfig.defaultMargin + 5,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButtonLabel(
              label: "Create Campaign",
              onTap: () => _onCreateCampaign(context),
            ),
          ],
        ),
      ),
    );
  }

  void _onCreateCampaign(
    BuildContext context,
  ) {
    // TODO => connect Create campaign to server
  }
}
