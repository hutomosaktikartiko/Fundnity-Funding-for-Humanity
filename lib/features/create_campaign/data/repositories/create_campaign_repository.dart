import 'dart:io';

import 'package:web3dart/web3dart.dart';

import '../../../../core/models/return_value_model.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../shared/config/label_config.dart';
import '../datasources/create_campaign_remote_data_source.dart';
import '../models/create_campaign_model.dart';
import '../models/ipfs_upload_model.dart';

abstract class CreateCampaignRepository {
  Future<ReturnValueModel> createCampaign({
    required CreateCampaignModel campaign,
    required Web3Client web3Client,
    required DeployedContract contract,
    required String walletPrivateKey,
  });
  Future<ReturnValueModel<IpfsUploadModel>> uploadImage({
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
  Future<ReturnValueModel<IpfsUploadModel>> uploadImage({
    required File image,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final IpfsUploadModel result =
            await createCampaignRemoteDataSource.uploadImage(image: image);

        return ReturnValueModel(
          isSuccess: true,
          value: result,
          message: "Berhasil mengupload gambar",
        );
      } catch (error) {
        return ReturnValueModel(message: error.toString());
      }
    } else {
      return ReturnValueModel(message: LabelConfig.noInternet);
    }
  }

  @override
  Future<ReturnValueModel> createCampaign({
    required CreateCampaignModel campaign,
    required Web3Client web3Client,
    required DeployedContract contract,
    required String walletPrivateKey,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final String result =
            await createCampaignRemoteDataSource.createCampaign(
          campaign: campaign,
          contract: contract,
          web3Client: web3Client,
          walletPrivateKey: walletPrivateKey,
        );

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
