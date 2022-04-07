import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/gas_model.dart';

part 'selected_transaction_speed_state.dart';

class SelectedTransactionSpeedCubit
    extends Cubit<SelectedTransactionSpeedState> {
  SelectedTransactionSpeedCubit()
      : super(SelectedTransactionSpeedState(
          gas: null,
        ));

  void setSelectedTransactionSpeed({required GasModel? gas}) {
    emit(SelectedTransactionSpeedState(
      gas: gas,
    ));
  }
}
