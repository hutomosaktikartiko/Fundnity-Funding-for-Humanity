import 'package:web3dart/web3dart.dart';

import '../../../../core/models/return_value_model.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../shared/config/label_config.dart';
import '../models/contributor_model.dart';
import '../datasources/contribute_remote_data_source.dart';

abstract class ContributeRepository {
  Future<ReturnValueModel<List<ContributorModel?>>> getContributors({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  });
  Future<ReturnValueModel> contribute({
    required BigInt amount,
    required DeployedContract deployedContract,
    required Web3Client web3Client,
    required String walletPrivateKey,
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
    required String walletPrivateKey,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final String result = await contributeRemoteDataSource.contribute(
          amount: amount,
          deployedContract: deployedContract,
          web3Client: web3Client,
          walletPrivateKey: walletPrivateKey,
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
