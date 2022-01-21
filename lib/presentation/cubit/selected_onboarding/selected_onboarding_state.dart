part of 'selected_onboarding_cubit.dart';

class SelectedOnboardingState extends Equatable {
  final int index;

  SelectedOnboardingState({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}
