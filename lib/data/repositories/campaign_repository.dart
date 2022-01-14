import 'package:web3dart/web3dart.dart';

import '../../core/config/label_config.dart';
import '../../core/network/network_info.dart';
import '../datasources/remotes/campaign_remote_data_source.dart';
import '../models/return_value_model.dart';

abstract class CampaignRepository {
  Future<ReturnValueModel<List<dynamic>>> getAllCampaigns({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
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
  Future<ReturnValueModel<List<dynamic>>> getAllCampaigns({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final List<dynamic> result =
            await campaignRemoteDataSource.getAllCampaign(
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
}
