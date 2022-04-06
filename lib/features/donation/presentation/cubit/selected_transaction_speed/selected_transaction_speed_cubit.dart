import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selected_transaction_speed_state.dart';

class SelectedTransactionSpeedCubit extends Cubit<SelectedTransactionSpeedState> {
  SelectedTransactionSpeedCubit() : super(SelectedTransactionSpeedState(
    gasTitle: null,
  ));

  void setSelectedTransactionSpeed({required String? gasTitle}) {
    emit(SelectedTransactionSpeedState(
      gasTitle: gasTitle,
    ));
  }
}
