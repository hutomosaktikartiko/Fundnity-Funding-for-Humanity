import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/utils/screen_navigator.dart';
import '../../../../shared/config/custom_color.dart';
import '../../../../shared/config/custom_text_style.dart';
import '../../../../shared/config/size_config.dart';
import '../../../../shared/widgets/show_image/show_image_file.dart';
import '../../create_campaign/create_campaign_screen.dart';
import 'review_card.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  final String? title;
  final File? image;

  @override
  Widget build(BuildContext context) {
    return ReviewCard(
      onEdit: () => _onEdit(context),
      number: "2",
      title: "Title",
      bodyCard: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Campaign title",
              style: CustomTextStyle.gray2TextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title ?? "-",
              style: CustomTextStyle.gray2TextStyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 30,
              thickness: 1,
              color: UniversalColor.gray5,
            ),
            Text(
              "Campaign photo",
              style: CustomTextStyle.gray2TextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ShowImageFile(
              imageFile: image!,
              width: SizeConfig.screenWidth,
              height: 200,
              borderRadius: BorderRadius.circular(5),
            ),
          ],
        ),
      ),
    );
  }

  void _onEdit(BuildContext context) {
    ScreenNavigator.startScreen(context, CreateCampaignScreen(index: 1));
  }
}
