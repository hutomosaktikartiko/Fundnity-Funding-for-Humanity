part of 'selected_transaction_speed_cubit.dart';

class SelectedTransactionSpeedState extends Equatable {
  final GasModel? gas;

  SelectedTransactionSpeedState({
    required this.gas
  });

  @override
  List<Object?> get props => [gas];
}