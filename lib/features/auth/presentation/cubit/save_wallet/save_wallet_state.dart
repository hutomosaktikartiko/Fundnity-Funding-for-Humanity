part of 'save_wallet_cubit.dart';

abstract class SaveWalletState extends Equatable {
  const SaveWalletState();

  @override
  List<Object?> get props => [];
}

class SaveWalletInitial extends SaveWalletState {}

class SaveWalletLoading extends SaveWalletState {}

class SaveWalletSuccess extends SaveWalletState {}

class SaveWalletFailure extends SaveWalletState {
  final String? message;

  const SaveWalletFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

