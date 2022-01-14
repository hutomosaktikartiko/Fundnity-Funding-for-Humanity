import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../data/models/contract_local_model.dart';
import '../../../data/models/return_value_model.dart';
import '../../../data/repositories/deployed_contract_repository.dart';

part 'campaign_factory_deployed_contract_state.dart';

class CampaignFactoryDeployedContractCubit
    extends Cubit<CampaignFactoryDeployedContractState> {
  CampaignFactoryDeployedContractCubit({
    required this.deployedContractRepository,
  }) : super(CampaignFactoryDeployedContractInitial());

  final DeployedContractRepository deployedContractRepository;

  Future<ReturnValueModel<bool>> getDeployedContract() async {
    final ReturnValueModel<DeployedContract> result =
        await deployedContractRepository.getDeployedContract(
      contractName: campaignFactoryContractLocal.name,
      contractAddress: campaignFactoryContractLocal.address,
      contractLocalUrl: campaignFactoryContractLocal.path,
    );

    if (result.isSuccess) {
      emit(CampaignFactoryDeployedContractLoaded(deployedContract: result.value));
    } else {
      emit(CampaignFactoryDeployedContractLoadingFailure(message: result.message));
    }

    return ReturnValueModel(
      isSuccess: result.isSuccess,
      message: result.message,
    );
  }
}
