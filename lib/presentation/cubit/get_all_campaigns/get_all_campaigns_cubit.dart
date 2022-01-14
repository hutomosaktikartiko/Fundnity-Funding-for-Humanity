import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../data/models/return_value_model.dart';
import '../../../data/repositories/campaign_repository.dart';

part 'get_all_campaigns_state.dart';

class GetAllCampaignsCubit extends Cubit<GetAllCampaignsState> {
  GetAllCampaignsCubit({
    required this.campaignRepository,
  }) : super(GetAllCampaignsInitial());

  final CampaignRepository campaignRepository;

  Future<ReturnValueModel<bool>> getAllCampaigns({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  }) async {
    final ReturnValueModel<List<dynamic>> result =
        await campaignRepository.getAllCampaigns(
      deployedContract: deployedContract,
      web3Client: web3Client,
    );

    if (result.isSuccess) {
      emit(GetAllCampaignsLoaded(listCampaigns: result.value));
    } else {
      emit(GetAllCampaignsLoadingFailure(message: result.message));
    }

    return ReturnValueModel(
      isSuccess: result.isSuccess,
      message: result.message,
    );
  }
}
