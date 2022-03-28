import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../../../../core/utils/utils.dart';
import '../../../../../../../../../data/models/select_image_action_model.dart';
import '../../../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../../../shared/config/size_config.dart';
import '../../../../../../../../../shared/widgets/show_image/show_image_file.dart';
import '../../../../../../cubit/create_campaign_target_data/create_campaign_data_cubit.dart';
import '../../../../../../cubit/selected_image/selected_image_cubit.dart';
import '../../../custom_text_description.dart';
import '../../../custom_text_title.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  final File? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextTitle(title: "Upload campaign photo"),
        const SizedBox(
          height: 10,
        ),
        CustomTextDescription(
          title:
              "The photo you upload here will be the main photo on your campaign page",
        ),
        const SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () => showSelectImageActionSheet(context),
          child: buildImage(),
        ),
      ],
    );
  }

  Widget buildImage() {
    if (image == null) {
      return Container(
        width: SizeConfig.screenWidth,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: UniversalColor.gray4,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_camera,
              color: UniversalColor.green4,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Upload photo",
              style: CustomTextStyle.green4TextStyle,
            )
          ],
        ),
      );
    } else {
      return ShowImageFile(
        imageFile: image!,
        width: SizeConfig.screenWidth,
        height: 200,
        borderRadius: BorderRadius.circular(5),
      );
    }
  }

  void showSelectImageActionSheet(BuildContext context) {
    // Hide keyboard
    Utils.hideKeyboard(context);
    // Show modalBottomSheet
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: mockListSelectImageActions
              .asMap()
              .map(
                (key, value) => MapEntry(
                  key,
                  ListTile(
                    leading: Icon(value.icon),
                    title: Text(value.title),
                    onTap: () => _onSelectPhoto(
                      context: context,
                      imageSource: value.imageSource,
                    ),
                  ),
                ),
              )
              .values
              .toList(),
        );
      },
    );
  }

  void _onSelectPhoto({
    required BuildContext context,
    required ImageSource imageSource,
  }) async {
    // Select Image
    File? result = await context
        .read<SelectedImageCubit>()
        .selectImageCampaign(imageSource: imageSource);

    if (result != null) {
      context.read<CreateCampaignDataCubit>().setImage(image: result);
    }

    // Close bottomSheet
    ScreenNavigator.closeScreen(context);
  }
}
