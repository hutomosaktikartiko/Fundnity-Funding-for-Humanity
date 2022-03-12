import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/custom_color.dart';
import '../../../core/config/custom_text_style.dart';
import '../../../core/config/size_config.dart';
import '../../../core/utils/utils.dart';
import '../../cubit/cubits.dart';
import 'widgets/create_campaign_body.dart';
import 'widgets/create_campaign_button.dart';
import 'widgets/create_campaign_progress.dart';

class CreateCampaignScreen extends StatefulWidget {
  const CreateCampaignScreen({
    Key? key,
    this.index,
  }) : super(key: key);

  final int? index;

  @override
  _CreateCampaignScreenState createState() => _CreateCampaignScreenState();
}

class _CreateCampaignScreenState extends State<CreateCampaignScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CreateCampaignProgressCubit>().changeIndex(index: widget.index ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Campaign',
          style: CustomTextStyle.whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => Utils.hideKeyboard(context),
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.defaultMargin,
          ),
          children: [
            const SizedBox(
              height: 20,
            ),
            CreateCampaignProress(),
            const SizedBox(
              height: 20,
            ),
            CreateCampaignBody(),
          ],
        ),
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
            CreateCampaignButton(),
          ],
        ),
      ),
    );
  }
}
