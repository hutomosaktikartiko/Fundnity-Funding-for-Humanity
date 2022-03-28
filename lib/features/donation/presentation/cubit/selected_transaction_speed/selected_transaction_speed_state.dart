part of 'selected_transaction_speed_cubit.dart';

class SelectedTransactionSpeedState extends Equatable {
  final MockTransactionSpeed? selectedTransactionSpeed;

  SelectedTransactionSpeedState({
    required this.selectedTransactionSpeed
  });

  @override
  List<Object?> get props => [selectedTransactionSpeed];
}