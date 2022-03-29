import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../core/models/return_value_model.dart';
import '../../../data/models/contract_local_model.dart';
import '../../../data/repositories/deployed_contract_repository.dart';

part 'crowdfunding_deployed_contract_state.dart';

class CrowdfundingDeployedContractCubit
    extends Cubit<CrowdfundingDeployedContractState> {
  CrowdfundingDeployedContractCubit({
    required this.deployedContractRepository,
  }) : super(CrowdfundingDeployedContractInitial()) {
    getDeployedContract();
  }

  final DeployedContractRepository deployedContractRepository;

  Future<ReturnValueModel<DeployedContract>> getDeployedContract() async {
    final ReturnValueModel<DeployedContract> result =
        await deployedContractRepository.getDeployedContract(
      contractName: crowdfundingContractLocal.name,
      contractAddress: EthereumAddress.fromHex(crowdfundingContractLocal.address),
      contractLocalUrl: crowdfundingContractLocal.path,
    );

    if (result.isSuccess && result.value != null) {
      emit(CrowdfundingDeployedContractLoaded(deployedContract: result.value!));
    } else {
      emit(CrowdfundingDeployedContractLoadingFailure(message: result.message));
    }

    return result;
  }
}
