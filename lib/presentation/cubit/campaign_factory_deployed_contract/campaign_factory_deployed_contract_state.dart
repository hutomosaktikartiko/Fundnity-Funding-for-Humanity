part of 'campaign_factory_deployed_contract_cubit.dart';

abstract class CampaignFactoryDeployedContractState extends Equatable {
  const CampaignFactoryDeployedContractState();

  @override
  List<Object?> get props => [];
}

class CampaignFactoryDeployedContractInitial extends CampaignFactoryDeployedContractState {}


class CampaignFactoryDeployedContractLoaded extends CampaignFactoryDeployedContractState {
  final DeployedContract? deployedContract;

  CampaignFactoryDeployedContractLoaded({required this.deployedContract});

  @override
  List<Object?> get props => [deployedContract];
}

class CampaignFactoryDeployedContractLoadingFailure extends CampaignFactoryDeployedContractState {
  final String? message;

  CampaignFactoryDeployedContractLoadingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
