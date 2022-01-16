import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../data/models/campaign_model.dart';
import '../../../data/models/return_value_model.dart';
import '../../../data/repositories/campaign_repository.dart';

part 'get_campaign_state.dart';

class GetCampaignCubit extends Cubit<GetCampaignState> {
  GetCampaignCubit({
    required this.campaignRepository,
  }) : super(GetCampaignInitial());

  final CampaignRepository campaignRepository;

  Future<ReturnValueModel<bool>> getCampaign({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  }) async {
    final ReturnValueModel<CampaignModel> result =
        await campaignRepository.getCampaignDetail(
      deployedContract: deployedContract,
      web3Client: web3Client,
    );

    if (result.isSuccess && result.value != null) {
      emit(GetCampaignLoaded(campaign: result.value!));
    } else {
      emit(GetCampaignLoadingFailure(message: result.message));
    }

    return ReturnValueModel(
      isSuccess: result.isSuccess,
      message: result.message,
    );
  }
}
