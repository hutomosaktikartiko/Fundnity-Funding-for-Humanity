part of 'wallet_cubit.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoaded extends WalletState {
  final Wallet wallet;

  WalletLoaded({required this.wallet,});

  @override
  List<Object?> get props => [wallet];
}

class WalletLoadingFailure extends WalletState {
  final String? message;

  WalletLoadingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}