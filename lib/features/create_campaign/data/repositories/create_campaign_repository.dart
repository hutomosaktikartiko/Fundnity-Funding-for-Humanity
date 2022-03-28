import 'dart:io';

import 'package:web3dart/web3dart.dart';

import '../../../../core/models/return_value_model.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../shared/config/label_config.dart';
import '../datasources/create_campaign_remote_data_source.dart';
import '../models/create_campaign_model.dart';

typedef Future<String> _CreateCampaignRemoteDataSource();

abstract class CreateCampaignRepository {
  Future<ReturnValueModel> createCampaign({
    required CreateCampaignModel campaign,
    required Web3Client web3Client,
    required DeployedContract contract,
  });
  Future<ReturnValueModel> uploadImage({
    required File image,
  });
}

class CreateCampaignRepositoryImpl implements CreateCampaignRepository {
  final NetworkInfo networkInfo;
  final CreateCampaignRemoteDataSource createCampaignRemoteDataSource;

  CreateCampaignRepositoryImpl({
    required this.networkInfo,
    required this.createCampaignRemoteDataSource,
  });

  @override
  Future<ReturnValueModel> uploadImage({
    required File image,
  }) async {
    return await _create(
      createCampaignRemoteDataSource: () =>
          createCampaignRemoteDataSource.uploadImage(
        image: image,
      ),
    );
  }

  @override
  Future<ReturnValueModel> createCampaign({
    required CreateCampaignModel campaign,
    required Web3Client web3Client,
    required DeployedContract contract,
  }) async {
    return await _create(
      createCampaignRemoteDataSource: () =>
          createCampaignRemoteDataSource.createCampaign(
        campaign: campaign,
        web3Client: web3Client,
        contract: contract,
      ),
    );
  }

  Future<ReturnValueModel> _create(
      {required _CreateCampaignRemoteDataSource
          createCampaignRemoteDataSource}) async {
    if (await networkInfo.isConnected) {
      try {
        final String result = await createCampaignRemoteDataSource();

        return ReturnValueModel(
          isSuccess: true,
          value: result,
        );
      } catch (error) {
        return ReturnValueModel(message: error.toString());
      }
    } else {
      return ReturnValueModel(message: LabelConfig.noInternet);
    }
  }
}
