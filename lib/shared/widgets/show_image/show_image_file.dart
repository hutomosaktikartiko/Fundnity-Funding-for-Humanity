import 'dart:io';

import 'package:flutter/material.dart';

import 'show_image.dart';

class ShowImageFile extends StatelessWidget {
  const ShowImageFile({
    Key? key,
    required this.imageFile,
    this.borderRadius,
    this.height = 50,
    this.width = 50,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

  final File imageFile;
  final double height, width;
  final BorderRadius? borderRadius;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return ShowImage(
      imageProvider: FileImage(imageFile),
      height: height,
      width: width,
      borderRadius: borderRadius,
      boxFit: boxFit,
    );
  }
}
