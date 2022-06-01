import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../custom_dialog.dart';

class ShowSvgNetwork extends StatelessWidget {
  const ShowSvgNetwork({
    Key? key,
    this.height,
    this.width,
    this.isShowLoading = true,
    required this.assetUrl,
  }) : super(key: key);

  final double? height, width;
  final String assetUrl;
  final bool isShowLoading;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      assetUrl,
      height: height,
      width: width,
      placeholderBuilder: (isShowLoading) ? (BuildContext context) => Center(
        child: CustomDialog.showCircularProgressIndicator(),
      ) : null
    );
  }
}