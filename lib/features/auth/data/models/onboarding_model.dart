import '../../../../shared/config/label_config.dart';

class OnboardingModel {
  int? id;
  String? label, description, imageName;

  OnboardingModel({
    this.id,
    this.description,
    this.label,
    this.imageName,
  });
}

final List<OnboardingModel> mockListOnboarding = [
  OnboardingModel(
    id: 1,
     imageName: 'onboarding_1.png',
          label: LabelConfig.onboarding1Label,
          description: LabelConfig.onboarding1Description,
  ),
  OnboardingModel(
    id: 2,
     imageName: 'onboarding_2.png',
          label: LabelConfig.onboarding2Label,
          description: LabelConfig.onboarding2Description,
  ),
  OnboardingModel(
    id: 3,
    imageName: 'onboarding_3.png',
          label: LabelConfig.onboarding3Label,
          description: LabelConfig.onboarding3Description,
  ),
];