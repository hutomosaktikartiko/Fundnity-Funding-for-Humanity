import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({
    Key? key,
    required this.borderRadius,
    required this.height,
    required this.width,
    required this.imageProvider,
    this.boxFit,
  }) : super(key: key);

  final double borderRadius, height, width;
  final ImageProvider<Object> imageProvider;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: FadeInImage(
        placeholder: AssetImage("assets/images/placeholder.jpg"),
        image: imageProvider,
        height: height,
        width: width,
        fit: boxFit,
      ),
    );
  }
}
