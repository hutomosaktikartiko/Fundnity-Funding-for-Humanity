import 'package:flutter/material.dart';

import '../../config/asset_path_config.dart';
import '../../config/custom_text_style.dart';
import '../../config/size_config.dart';
import '../show_svg/show_svg_asset.dart';

class EmptyCampaign extends StatelessWidget {
  const EmptyCampaign({
    Key? key,
    required this.height,
    required this.description,
    required this.title,
  }) : super(key: key);

  final double height;
  final String title, description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShowSvgAsset(
            assetUrl: AssetPathConfig.emptyPath,
            height: height,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
           title,
            style: CustomTextStyle.gray1TextStyle
                .copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            description,
            style: CustomTextStyle.gray3TextStyle.copyWith(),
          )
        ],
      ),
    );
  }
}
