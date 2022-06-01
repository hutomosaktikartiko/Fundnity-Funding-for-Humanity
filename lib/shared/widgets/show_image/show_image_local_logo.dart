import 'package:flutter/material.dart';

import '../../config/asset_path_config.dart';
import 'show_image_local.dart';

class ShowImageLocalLogo extends StatelessWidget {
  const ShowImageLocalLogo({
    Key? key,
    this.borderRadius,
    this.height = 50,
    this.width = 50,
  }) : super(key: key);

  final double height, width;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ShowImageLocal(
      imageUrl: AssetPathConfig.appLogo,
      height: height,
      width: width,
      borderRadius: borderRadius,
    );
  }
}
