import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../core/models/return_value_model.dart';
import '../../../../main/presentation/cubit/campaign_deployed_contract/campaign_deployed_contract_cubit.dart';
import '../../../data/repositories/contribute_repository.dart';

part 'contribute_state.dart';

class ContributeCubit extends Cubit<ContributeState> {
  ContributeCubit({
    required this.contributeRepository,
    required this.campaignDeployedContractCubit,
  }) : super(ContributeInitial());

  final ContributeRepository contributeRepository;
  final CampaignDeployedContractCubit campaignDeployedContractCubit;

  Future<ReturnValueModel> contribute({
    required Web3Client web3Client,
    required String walletPrivateKey,
    required BigInt amount,
    required EthereumAddress? address,
  }) async {
    emit(ContributeLoading());

    // Get CampaignDeployedContract
    final ReturnValueModel<DeployedContract> deployedContract =
        await campaignDeployedContractCubit.getDeployedContract(
            address: address);

    if (deployedContract.isSuccess && deployedContract.value != null) {
      // Contribute
      final ReturnValueModel result = await contributeRepository.contribute(
        amount: amount,
        deployedContract: deployedContract.value!,
        web3Client: web3Client,
        walletPrivateKey: walletPrivateKey,
      );
      if (result.isSuccess) {
        emit(ContributeLoaded());
      } else {
        emit(ContributeLoadingFailure(message: result.message));
      }
      return result;
    } else {
      emit(ContributeLoadingFailure(message: deployedContract.message));

      return deployedContract;
    }
  }
}
