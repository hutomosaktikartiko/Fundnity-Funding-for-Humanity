part of 'one_signal_cubit.dart';

abstract class OneSignalState extends Equatable {
  const OneSignalState();

  @override
  List<Object> get props => [];
}

class OneSignalInitial extends OneSignalState {}

class OneSignalLoading extends OneSignalState {}

class OneSignalLoaded extends OneSignalState {
  final OSDeviceState osDeviceState;

  OneSignalLoaded({required this.osDeviceState});

  @override
  List<Object> get props => [osDeviceState];
}

class OneSignalFailure extends OneSignalState {
  final String message;

  OneSignalFailure({required this.message});

  @override
  List<Object> get props => [message];
}