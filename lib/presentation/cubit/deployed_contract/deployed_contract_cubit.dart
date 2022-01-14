import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../data/models/return_value_model.dart';
import '../../../data/repositories/deployed_contract_repository.dart';

part 'deployed_contract_state.dart';

class DeployedContractCubit extends Cubit<DeployedContractState> {
  DeployedContractCubit({
    required this.deployedContractRepository,
  }) : super(DeployedContractInitial());

  final DeployedContractRepository deployedContractRepository;

  Future<ReturnValueModel<bool>> getDeployedContract({
    required String contractName,
    required String contractAddress,
    required String contractLocalUrl,
  }) async {
    final ReturnValueModel<DeployedContract> result =
        await deployedContractRepository.getDeployedContract(
      contractName: contractName,
      contractAddress: contractAddress,
      contractLocalUrl: contractLocalUrl,
    );

    if (result.isSuccess) {
      emit(DeployedContractLoaded(deployedContract: result.value));
    } else {
      emit(DeployedContractLoadingFailure(message: result.message));
    }

    return ReturnValueModel(
      isSuccess: result.isSuccess,
      message: result.message,
    );
  }
}
