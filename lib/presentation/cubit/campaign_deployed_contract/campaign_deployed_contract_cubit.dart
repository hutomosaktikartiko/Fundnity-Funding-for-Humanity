import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../data/models/contract_local_model.dart';
import '../../../data/models/return_value_model.dart';
import '../../../data/repositories/deployed_contract_repository.dart';

part 'campaign_deployed_contract_state.dart';

class CampaignDeployedContractCubit
    extends Cubit<CampaignDeployedContractState> {
  CampaignDeployedContractCubit({
    required this.deployedContractRepository,
  }) : super(CampaignDeployedContractInitial());

  final DeployedContractRepository deployedContractRepository;

  Future<ReturnValueModel<bool>> getDeployedContract() async {
    final ReturnValueModel<DeployedContract> result =
        await deployedContractRepository.getDeployedContract(
      contractName: campaignContractLocal.name,
      contractAddress: campaignContractLocal.address,
      contractLocalUrl: campaignContractLocal.path,
    );

    if (result.isSuccess) {
      emit(CampaignDeployedContractLoaded(deployedContract: result.value));
    } else {
      emit(CampaignDeployedContractLoadingFailure(message: result.message));
    }

    return ReturnValueModel(
      isSuccess: result.isSuccess,
      message: result.message,
    );
  }
}
