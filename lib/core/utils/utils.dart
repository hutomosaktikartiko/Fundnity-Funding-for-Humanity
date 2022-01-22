import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

import '../../injection_container.dart';

class Utils {
  static void hideKeyboard(BuildContext context) =>
      FocusScope.of(context).requestFocus(FocusNode());

  static Future<File?> selectImage({
    required ImageSource imageSource,
  }) async {
    final ImagePicker _picker = sl<ImagePicker>();
    XFile? pickedImage = await _picker.pickImage(source: imageSource);
    // PickedFile == null return null
    if (pickedImage == null) return null;
    // PickedFile != null & imageSource == camera return compressedImage
    if (imageSource == ImageSource.camera)
      return compressImage(image: pickedImage);
    // ImageSource Gallery
    return File(pickedImage.path);
  }

  static Future<File?> compressImage({
    required XFile image,
  }) async {
    final ImageProperties _properties =
        await FlutterNativeImage.getImageProperties(
      image.path,
    );
    return await FlutterNativeImage.compressImage(
      image.path,
      quality: 80,
      targetWidth: 600,
      targetHeight:
          ((_properties.height ?? 1) * 600 / (_properties.width ?? 1)).round(),
    );
  }

  static Future<File?> selectFile() async {
    // Selec file
    final FilePickerResult? result = await sl<FilePicker>().pickFiles();
    // if selectFile result == null return null
    if (result == null) return null;
    // selectFile result != null
    return File(result.files.single.path!);
  }
}
