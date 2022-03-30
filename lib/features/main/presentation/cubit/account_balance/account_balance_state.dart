part of 'account_balance_cubit.dart';

abstract class AccountBalanceState extends Equatable {
  const AccountBalanceState();

  @override
  List<Object?> get props => [];
}

class AccountBalanceInitial extends AccountBalanceState {}


class AccountBalanceLoading extends AccountBalanceState {}

class AccountBalanceLoaded extends AccountBalanceState {
  final EtherAmount balance;

  AccountBalanceLoaded({required this.balance});

  @override
  List<Object?> get props => [balance];
}

class AccountBalanceLoadingFailure extends AccountBalanceState {
  final String? message;

  AccountBalanceLoadingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}