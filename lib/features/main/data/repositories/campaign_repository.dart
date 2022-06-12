import 'package:web3dart/web3dart.dart';

import '../../../../core/models/return_value_model.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../shared/config/label_config.dart';
import '../datasources/campaign_remote_data_source.dart';
import '../models/campaign_firestore_model.dart';
import '../models/campaign_model.dart';

abstract class CampaignRepository {
  Future<ReturnValueModel<List<dynamic>>> getAllAddressCampaigns({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  });
  Future<ReturnValueModel<CampaignModel>> getCampaignDetail({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  });
  Future<ReturnValueModel<List<CampaignFirestoreModel>>> getMyCampaigns({
    required EthereumAddress? address,
  });
  Future<ReturnValueModel> claimCampaign({
    required DeployedContract contract,
    required Web3Client web3Client,
    required EthPrivateKey walletPrivateKey,
    required CampaignModel campaign,
  });
}

class CampaignRepositoryImpl implements CampaignRepository {
  final NetworkInfo networkInfo;
  final CampaignRemoteDataSource campaignRemoteDataSource;

  CampaignRepositoryImpl({
    required this.networkInfo,
    required this.campaignRemoteDataSource,
  });

  @override
  Future<ReturnValueModel<List<dynamic>>> getAllAddressCampaigns({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final List<dynamic> result =
            await campaignRemoteDataSource.getAllAddressCampaigns(
          deployedContract: deployedContract,
          web3Client: web3Client,
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

  @override
  Future<ReturnValueModel<CampaignModel>> getCampaignDetail({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final CampaignModel result =
            await campaignRemoteDataSource.getCampaignDetail(
          deployedContract: deployedContract,
          web3Client: web3Client,
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

  @override
  Future<ReturnValueModel<List<CampaignFirestoreModel>>> getMyCampaigns({
    required EthereumAddress? address,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final List<CampaignFirestoreModel> result =
            await campaignRemoteDataSource.getMyCampaigns(
          address: address,
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

  @override
  Future<ReturnValueModel> claimCampaign({
    required DeployedContract contract,
    required Web3Client web3Client,
    required EthPrivateKey walletPrivateKey,
    required CampaignModel campaign,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final String result =
            await campaignRemoteDataSource.claimCampaign(
          contract: contract,
          web3Client: web3Client,
          walletPrivateKey: walletPrivateKey,
          campaign: campaign,
        );

        return ReturnValueModel(
          isSuccess: true,
          message: result,
        );
      } catch (error) {
        return ReturnValueModel(message: error.toString());
      }
    } else {
      return ReturnValueModel(message: LabelConfig.noInternet);
    }
  }
}
