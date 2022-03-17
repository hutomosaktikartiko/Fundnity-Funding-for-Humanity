part of 'crowdfunding_deployed_contract_cubit.dart';

abstract class CrowdfundingDeployedContractState extends Equatable {
  const CrowdfundingDeployedContractState();

  @override
  List<Object?> get props => [];
}

class CrowdfundingDeployedContractInitial extends CrowdfundingDeployedContractState {}


class CrowdfundingDeployedContractLoaded extends CrowdfundingDeployedContractState {
  final DeployedContract deployedContract;

  CrowdfundingDeployedContractLoaded({required this.deployedContract});

  @override
  List<Object?> get props => [deployedContract];
}

class CrowdfundingDeployedContractLoadingFailure extends CrowdfundingDeployedContractState {
  final String? message;

  CrowdfundingDeployedContractLoadingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
