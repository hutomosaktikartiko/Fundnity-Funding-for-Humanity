import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../core/models/return_value_model.dart';
import '../../../data/models/create_campaign_model.dart';
import '../../../data/models/ipfs_upload_model.dart';
import '../../../data/repositories/create_campaign_repository.dart';

part 'create_campaign_state.dart';

class CreateCampaignCubit extends Cubit<CreateCampaignState> {
  CreateCampaignCubit({
    required this.createCampaignRepository,
  }) : super(CreateCampaignInitial());

  final CreateCampaignRepository createCampaignRepository;

  Future<ReturnValueModel<IpfsUploadModel>> uploadImage({
    required File image,
  }) async {
    final ReturnValueModel<IpfsUploadModel> result =
        await createCampaignRepository.uploadImage(image: image);

    return result;
  }

  Future<ReturnValueModel> createCampaign({
    required CreateCampaignModel campaign,
    required Web3Client web3Client,
    required DeployedContract contract,
    required String walletPrivateKey,
  }) async {
    final ReturnValueModel result =
        await createCampaignRepository.createCampaign(
      campaign: campaign,
      web3Client: web3Client,
      contract: contract,
      walletPrivateKey: walletPrivateKey,
    );

    return result;
  }
}
