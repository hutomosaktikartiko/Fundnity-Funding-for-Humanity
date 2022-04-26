part of 'history_cubit.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<HistoryModel> history;

  const HistoryLoaded({
    required this.history,
  });

  @override
  List<Object?> get props => [history];
}

class HistoryEmpty extends HistoryState {}

class HistoryFailure extends HistoryState {
  final String? message;

  const HistoryFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
