import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../core/models/return_value_model.dart';
import '../../../data/repositories/campaign_repository.dart';

part 'get_all_address_campaigns_state.dart';

class GetAllAddressCampaignsCubit extends Cubit<GetAllAddressCampaignsState> {
  GetAllAddressCampaignsCubit({
    required this.campaignRepository,
  }) : super(GetAllAddressCampaignsInitial());

  final CampaignRepository campaignRepository;

  Future<ReturnValueModel<bool>> getAllAddressCampaigns({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  }) async {
    final ReturnValueModel<List> result =
        await campaignRepository.getAllAddressCampaigns(
      deployedContract: deployedContract,
      web3Client: web3Client,
    );

    if (result.isSuccess) {
      emit(GetAllAddressCampaignsLoaded(listAddressCampaigns: result.value ?? []));
    } else {
      emit(GetAllAddressCampaignsLoadingFailure(message: result.message));
    }

    return ReturnValueModel(
      isSuccess: result.isSuccess,
      message: result.message,
    );
  }
}
