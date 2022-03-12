import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageActionModel {
  IconData icon;
  String title;
  ImageSource imageSource;

  SelectImageActionModel({
    required this.icon,
    required this.title,
    required this.imageSource,
  });
}

final List<SelectImageActionModel> mockListSelectImageActions = [
  SelectImageActionModel(
    icon: Icons.photo_camera,
    title: "Camera",
    imageSource: ImageSource.camera,
  ),
  SelectImageActionModel(
    icon: Icons.perm_media,
    title: "Gallery",
    imageSource: ImageSource.gallery,
  ),
];
