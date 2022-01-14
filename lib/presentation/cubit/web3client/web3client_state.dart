part of 'web3client_cubit.dart';

class Web3clientState extends Equatable {
  final Web3Client web3client;

  Web3clientState({
    required this.web3client,
  });

  @override
  List<Object?> get props => [web3client];
}
