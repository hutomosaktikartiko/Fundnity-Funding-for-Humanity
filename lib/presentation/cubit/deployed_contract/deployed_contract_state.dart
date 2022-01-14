part of 'deployed_contract_cubit.dart';

abstract class DeployedContractState extends Equatable {
  const DeployedContractState();

  @override
  List<Object?> get props => [];
}

class DeployedContractInitial extends DeployedContractState {}

class DeployedContractLoaded extends DeployedContractState {
  final DeployedContract? deployedContract;

  DeployedContractLoaded({required this.deployedContract});

  @override
  List<Object?> get props => [deployedContract];
}

class DeployedContractLoadingFailure extends DeployedContractState {
  final String? message;

  DeployedContractLoadingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
