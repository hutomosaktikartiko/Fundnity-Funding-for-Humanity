import 'package:flutter/material.dart';

import '../../../../../../../core/config/custom_color.dart';
import '../../../../../../../core/config/custom_text_style.dart';
import '../../../../../../../core/config/size_config.dart';
import '../../../../../../widgets/show_image/show_image_local.dart';
import '../../../custom_text_description.dart';
import '../../../custom_text_title.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String? image;

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
          onTap: _onSelectPhoto,
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
      return ShowImageLocal(
        imageUrl: image!,
        height: 200,
        borderRadius: BorderRadius.circular(5),
      );
    }
  }

  void _onSelectPhoto() {
    // TODO => Select Photo, Crop photo (height [200], width [screenWidth]), Compress photo
  }
}
