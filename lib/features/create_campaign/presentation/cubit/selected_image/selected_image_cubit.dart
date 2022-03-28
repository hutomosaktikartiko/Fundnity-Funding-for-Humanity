import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/utils/utils.dart';

part 'selected_image_state.dart';

class SelectedImageCubit extends Cubit<SelectedImageState> {
  SelectedImageCubit() : super(SelectedImageState());

  Future<File?> selectImageCampaign({
    required ImageSource imageSource,
  }) async {
    File? selectedImage = await Utils.selectImage(imageSource: imageSource);

    File? croppedImage = await Utils.cropImage(selectedImage);

    if (croppedImage == null) return null;

    File? compressedImage = await Utils.compressImage(
      image: croppedImage,
    );

    emit(SelectedImageState(image: compressedImage));

    return compressedImage;
  }
}
