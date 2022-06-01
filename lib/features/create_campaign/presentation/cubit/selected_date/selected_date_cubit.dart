import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'selected_date_state.dart';

class SelectedDateCubit extends Cubit<SelectedDateState> {
  SelectedDateCubit()
      : super(SelectedDateState(
          selectedDate: null,
        ));

  void setSelectedDate({required DateTime? selectedDate}) {
    emit(SelectedDateState(
      selectedDate: selectedDate,
    ));
  }

  void openCalendar({
    required BuildContext context,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: state.selectedDate ?? DateTime.now().add(const Duration(days: 2)),
      firstDate: DateTime.now().add(const Duration(days: 2)),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    
    setSelectedDate(selectedDate: picked ?? state.selectedDate);
  }
}
