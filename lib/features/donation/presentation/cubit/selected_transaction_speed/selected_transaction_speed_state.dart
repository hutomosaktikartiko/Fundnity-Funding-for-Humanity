part of 'selected_transaction_speed_cubit.dart';

class SelectedTransactionSpeedState extends Equatable {
  final String? gasTitle;

  SelectedTransactionSpeedState({
    required this.gasTitle
  });

  @override
  List<Object?> get props => [gasTitle];
}