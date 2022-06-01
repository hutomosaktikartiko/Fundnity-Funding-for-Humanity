import '../../../../shared/config/asset_path_config.dart';
import '../../../../shared/config/label_config.dart';

class OnboardingModel {
  int? id;
  String? label, description, imagePath;

  OnboardingModel({
    this.id,
    this.description,
    this.label,
    this.imagePath,
  });
}

final List<OnboardingModel> mockListOnboardings = [
  OnboardingModel(
    id: 1,
     imagePath: AssetPathConfig.onBoardingFirstPath,
          label: LabelConfig.onboarding1Label,
          description: LabelConfig.onboarding1Description,
  ),
  OnboardingModel(
    id: 2,
     imagePath: AssetPathConfig.onBoardingSecondPath,
          label: LabelConfig.onboarding2Label,
          description: LabelConfig.onboarding2Description,
  ),
];