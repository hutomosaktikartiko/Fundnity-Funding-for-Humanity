part of 'gas_tracker_cubit.dart';

abstract class GasTrackerState extends Equatable {
  const GasTrackerState();

  @override
  List<Object?> get props => [];
}

class GasTrackerInitial extends GasTrackerState {}

class GasTrackerLoading extends GasTrackerState {}

class GasTrackerLoaded extends GasTrackerState {
  final List<GasModel?> listGas;

  GasTrackerLoaded({required this.listGas});

  @override
  List<Object?> get props => [listGas];
}

class GasTrackerLoadingFailure extends GasTrackerState {
  final String? message;

  GasTrackerLoadingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
