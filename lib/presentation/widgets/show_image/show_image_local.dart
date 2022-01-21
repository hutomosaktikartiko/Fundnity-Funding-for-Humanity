import 'package:flutter/material.dart';

import 'show_image.dart';

class ShowImageLocal extends StatelessWidget {
  const ShowImageLocal({
    Key? key,
    required this.imageUrl,
    this.borderRadius = 8,
    this.height = 50,
    this.width = 50,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

  final String imageUrl;
  final double height, width, borderRadius;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return ShowImage(
      imageProvider: AssetImage(imageUrl),
      height: height,
      width: width,
      borderRadius: borderRadius,
      boxFit: boxFit,
    );
  }
}
