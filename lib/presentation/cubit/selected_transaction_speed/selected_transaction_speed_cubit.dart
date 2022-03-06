import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/mock_transaction_speed.dart';

part 'selected_transaction_speed_state.dart';

class SelectedTransactionSpeedCubit extends Cubit<SelectedTransactionSpeedState> {
  SelectedTransactionSpeedCubit() : super(SelectedTransactionSpeedState(
    selectedTransactionSpeed: null,
  ));

  void setSelectedTransactionSpeed(MockTransactionSpeed? selectedTransactionSpeed) {
    emit(SelectedTransactionSpeedState(
      selectedTransactionSpeed: selectedTransactionSpeed,
    ));
  }
}
