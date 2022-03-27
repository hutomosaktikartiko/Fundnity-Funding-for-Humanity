import 'package:flutter/material.dart';

import 'show_image.dart';

class ShowImageNetwork extends StatelessWidget {
  const ShowImageNetwork({
    Key? key,
    required this.imageUrl,
    this.borderRadius,
    this.height = 50,
    this.width = 50,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

  final String imageUrl;
  final double height, width;
  final BorderRadius? borderRadius;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return ShowImage(
      imageProvider: NetworkImage(
        imageUrl,
      ),
      height: height,
      width: width,
      borderRadius: borderRadius,
      boxFit: boxFit,
    );
  }
}
