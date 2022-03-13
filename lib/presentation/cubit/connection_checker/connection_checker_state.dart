part of 'connection_checker_cubit.dart';

abstract class ConnectionCheckerState extends Equatable {
  const ConnectionCheckerState();

  @override
  List<Object?> get props => [];
}

class InternetConnectionLoading extends ConnectionCheckerState {}

class InternetConnectionConnected extends ConnectionCheckerState {}

class InternetConnectionDisconnected extends ConnectionCheckerState {
  final String message;

  InternetConnectionDisconnected({required this.message});

  @override
  List<Object?> get props => [message];
}
