import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../core/models/return_value_model.dart';
import '../../../data/models/contract_local_model.dart';
import '../../../data/repositories/deployed_contract_repository.dart';

part 'campaign_deployed_contract_state.dart';

class CampaignDeployedContractCubit
    extends Cubit<CampaignDeployedContractState> {
  CampaignDeployedContractCubit({
    required this.deployedContractRepository,
  }) : super(CampaignDeployedContractInitial());

  final DeployedContractRepository deployedContractRepository;

  Future<ReturnValueModel<bool>> getDeployedContract({
    required String address,
  }) async {
    final ReturnValueModel<DeployedContract> result =
        await deployedContractRepository.getDeployedContract(
      contractName: campaignContractLocal.name,
      contractAddress: address,
      contractLocalUrl: campaignContractLocal.path,
    );

    if (result.isSuccess && result.value != null) {
      emit(CampaignDeployedContractLoaded(deployedContract: result.value!));
    } else {
      emit(CampaignDeployedContractLoadingFailure(message: result.message));
    }

    return ReturnValueModel(
      isSuccess: result.isSuccess,
      message: result.message,
    );
  }
}
