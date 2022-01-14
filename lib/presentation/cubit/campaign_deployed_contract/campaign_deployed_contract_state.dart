part of 'campaign_deployed_contract_cubit.dart';

abstract class CampaignDeployedContractState extends Equatable {
  const CampaignDeployedContractState();

  @override
  List<Object?> get props => [];
}

class CampaignDeployedContractInitial extends CampaignDeployedContractState {}

class CampaignDeployedContractLoaded extends CampaignDeployedContractState {
  final DeployedContract? deployedContract;

  CampaignDeployedContractLoaded({required this.deployedContract});

  @override
  List<Object?> get props => [deployedContract];
}

class CampaignDeployedContractLoadingFailure extends CampaignDeployedContractState {
  final String? message;

  CampaignDeployedContractLoadingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
