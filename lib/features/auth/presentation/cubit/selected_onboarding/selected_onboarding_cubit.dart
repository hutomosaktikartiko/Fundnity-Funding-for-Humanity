import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selected_onboarding_state.dart';

class SelectedOnboardingCubit extends Cubit<SelectedOnboardingState> {
  SelectedOnboardingCubit() : super(SelectedOnboardingState(index: 0));

  void initialState() => emit(SelectedOnboardingState(index: 0));

  void changeOnboarding({required int index}) {
    emit(SelectedOnboardingState(index: index));
  }
}
