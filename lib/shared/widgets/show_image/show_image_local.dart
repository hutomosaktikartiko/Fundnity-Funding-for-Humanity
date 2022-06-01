import 'package:flutter/material.dart';

class ShowImageLocal extends StatelessWidget {
  const ShowImageLocal({
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
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: boxFit,
      ),
    );
  }
}
