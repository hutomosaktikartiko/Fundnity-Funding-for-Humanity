import 'package:web3dart/web3dart.dart';

import '../../../../core/models/return_value_model.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../shared/config/label_config.dart';
import '../../../main/data/models/campaign_model.dart';
import '../datasources/contribute_remote_data_source.dart';
import '../models/contributor_model.dart';

abstract class ContributeRepository {
  Future<ReturnValueModel<List<ContributorModel?>>> getContributors({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  });
  Future<ReturnValueModel> contribute({
    required BigInt amount,
    required DeployedContract deployedContract,
    required Web3Client web3Client,
    required EthPrivateKey walletPrivateKey,
    required CampaignModel? campaign,
  });
}

class ContributeRepositoryImpl implements ContributeRepository {
  final ContributeRemoteDataSource contributeRemoteDataSource;
  final NetworkInfo networkInfo;

  ContributeRepositoryImpl({
    required this.contributeRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<ReturnValueModel<List<ContributorModel?>>> getContributors({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final List<ContributorModel?> result =
            await contributeRemoteDataSource.getContributors(
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
  Future<ReturnValueModel> contribute({
    required BigInt amount,
    required DeployedContract deployedContract,
    required Web3Client web3Client,
    required EthPrivateKey walletPrivateKey,
    required CampaignModel? campaign,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final String result = await contributeRemoteDataSource.contribute(
          amount: amount,
          deployedContract: deployedContract,
          web3Client: web3Client,
          walletPrivateKey: walletPrivateKey,
          campaign: campaign,
        );

        return ReturnValueModel(
          isSuccess: true,
          value: result,
          message: "Success send donation, please wait for a confirmation",
        );
      } catch (error) {
        return ReturnValueModel(message: error.toString());
      }
    } else {
      return ReturnValueModel(message: LabelConfig.noInternet);
    }
  }
}
