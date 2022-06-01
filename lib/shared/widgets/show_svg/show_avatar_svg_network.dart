import 'package:flutter/material.dart';

import 'show_svg_network.dart';

class ShowAvatarSvgNetwork extends StatelessWidget {
  const ShowAvatarSvgNetwork({
    Key? key,
    this.height,
    this.width,
    this.isShowLoading = true,
    required this.address,
  }) : super(key: key);

  final double? height, width;
  final String address;
  final bool isShowLoading;

  @override
  Widget build(BuildContext context) {
    return ShowSvgNetwork(
      assetUrl: "https://source.boringavatars.com/pixel/120/$address",
      height: height,
      width: width,
      isShowLoading: isShowLoading,
    );
  }
}
