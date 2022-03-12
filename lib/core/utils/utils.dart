import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
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
    // ImageSource Gallery
    return File(pickedImage.path);
  }

  static Future<File?> compressImage({
    required File image,
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
    // Select file
    final FilePickerResult? result = await sl<FilePicker>().pickFiles();
    // if selectFile result == null return null
    if (result == null) return null;
    // selectFile result != null
    return File(result.files.single.path!);
  }

  static Future<File?> cropImage(File? imageFile) async {
    if (imageFile == null) return null;
    return await sl<ImageCropper>().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: "Crop Image",
        toolbarColor: Colors.blue,
        toolbarWidgetColor: Colors.white,
        lockAspectRatio: false,
      ),
      iosUiSettings: IOSUiSettings(
        aspectRatioLockEnabled: true,
      ),
    );
  }
}
