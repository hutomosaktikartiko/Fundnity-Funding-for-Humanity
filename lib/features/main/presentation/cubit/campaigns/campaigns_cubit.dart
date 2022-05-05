import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../core/models/return_value_model.dart';
import '../../../data/models/campaign_model.dart';
import '../../../data/repositories/campaign_repository.dart';
import '../campaign_deployed_contract/campaign_deployed_contract_cubit.dart';

part 'campaigns_state.dart';

class CampaignsCubit extends Cubit<CampaignsState> {
  CampaignsCubit({
    required this.campaignRepository,
    required this.campaignDeployedContractCubit,
  }) : super(CampaignsInitial());

  final CampaignRepository campaignRepository;
  final CampaignDeployedContractCubit campaignDeployedContractCubit;

  Future<void> getCampaigns({
    required Web3Client web3Client,
    required DeployedContract crowdfundindContract,
  }) async {
    emit(CampaignsLoading());

    final List<dynamic>? addresses = await getAllAddresses(
      web3Client: web3Client,
      crowdfundindContract: crowdfundindContract,
    );

    if (addresses == null) {
      emit(CampaignsLoadingFailure(message: "Failed to get all addresses"));
    } else {
      if (addresses.isEmpty) {
        emit(CampaignsEmpty());
      } else {
        List<CampaignModel> campaigns = [];

        for (var address in addresses) {
          final CampaignModel? campaign = await getCampaign(
            address: address,
            web3Client: web3Client,
          );

          if (campaign != null) {
            campaigns.add(campaign);
          }
        }

        emit(CampaignsLoaded(campaigns: campaigns));
      }
    }
  }

  Future<List<dynamic>?> getAllAddresses({
    required Web3Client web3Client,
    required DeployedContract crowdfundindContract,
  }) async {
    final ReturnValueModel<dynamic> result =
        await campaignRepository.getAllAddressCampaigns(
      deployedContract: crowdfundindContract,
      web3Client: web3Client,
    );

    if (result.isSuccess && result.value != null) {
      return result.value;
    } else {
      return null;
    }
  }

  Future<CampaignModel?> getCampaign({
    required dynamic address,
    required Web3Client web3Client,
  }) async {
    final ReturnValueModel<DeployedContract> contract =
        await campaignDeployedContractCubit.getDeployedContract(
      address: address,
    );

    if (contract.value != null) {
      final ReturnValueModel<CampaignModel> result =
          await campaignRepository.getCampaignDetail(
        deployedContract: contract.value!,
        web3Client: web3Client,
      );

      return result.value;
    } else {
      return null;
    }
  }
}
