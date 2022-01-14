part of 'ethereum_balance_cubit.dart';

abstract class EthereumBalanceState extends Equatable {
  const EthereumBalanceState();

  @override
  List<Object?> get props => [];
}

class EthereumBalanceInitial extends EthereumBalanceState {}

class EthereumBalanceLoaded extends EthereumBalanceState {
  final EtherAmount? etherAmount;

  EthereumBalanceLoaded({
    required this.etherAmount
  });

  @override
  List<Object?> get props => [etherAmount];
}

class EthereumBalanceLoadingFailure extends EthereumBalanceState {
  final String? message;

  EthereumBalanceLoadingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}