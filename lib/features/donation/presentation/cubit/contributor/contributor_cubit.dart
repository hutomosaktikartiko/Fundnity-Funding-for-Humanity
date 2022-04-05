import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../core/models/return_value_model.dart';
import '../../../../main/presentation/cubit/campaign_deployed_contract/campaign_deployed_contract_cubit.dart';
import '../../../data/models/contributor_model.dart';
import '../../../data/repositories/contributor_repository.dart';

part 'contributor_state.dart';

class ContributorCubit extends Cubit<ContributorState> {
  ContributorCubit({
    required this.contributorRepository,
    required this.campaignDeployedContractCubit,
  }) : super(ContributorInitial());

  final ContributorRepository contributorRepository;
  final CampaignDeployedContractCubit campaignDeployedContractCubit;

  void getContributors({
    required EthereumAddress? address,
    required Web3Client web3Client,
  }) async {
    emit(ContributorLoading());

    // Get CampaignDeployedContract
    final ReturnValueModel<DeployedContract> deployedContract =
        await campaignDeployedContractCubit.getDeployedContract(
            address: address);

    if (deployedContract.isSuccess && deployedContract.value != null) {
      // Get Contributors
      final ReturnValueModel<List<ContributorModel?>> result =
          await contributorRepository.getContributors(
        deployedContract: deployedContract.value!,
        web3Client: web3Client,
      );

      if (result.isSuccess && result.value != null) {
        if (result.value!.length > 0) {
          emit(ContributorLoaded(
            contributors: result.value!,
          ));
        } else {
          emit(ContributorEmpty());
        }
      } else {
        emit(ContributorLoadingFailure(message: result.message));
      }
    } else {
      emit(ContributorLoadingFailure(message: deployedContract.message));
    }
  }
}
