part of 'ethereum_cubit.dart';

abstract class EthereumState extends Equatable {
  const EthereumState();

  @override
  List<Object> get props => [];
}

class EthereumInitial extends EthereumState {}
