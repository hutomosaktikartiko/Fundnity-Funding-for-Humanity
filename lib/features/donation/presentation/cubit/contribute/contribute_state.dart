part of 'contribute_cubit.dart';

abstract class ContributeState extends Equatable {
  const ContributeState();

  @override
  List<Object?> get props => [];
}

class ContributeInitial extends ContributeState {}

class ContributeLoading extends ContributeState {}

class ContributeLoaded extends ContributeState {}

class ContributeLoadingFailure extends ContributeState {
  final String? message;

  ContributeLoadingFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}