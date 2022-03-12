part of 'selected_image_cubit.dart';

class SelectedImageState extends Equatable {
  final File? image;

  const SelectedImageState({
    this.image,
  });

  @override
  List<Object?> get props => [image];
}
