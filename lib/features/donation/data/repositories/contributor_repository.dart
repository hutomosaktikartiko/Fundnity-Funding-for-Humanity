import 'package:web3dart/web3dart.dart';

import '../../../../core/models/return_value_model.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../shared/config/label_config.dart';
import '../models/contributor_model.dart';
import '../datasources/contributor_remote_data_source.dart';

abstract class ContributorRepository {
  Future<ReturnValueModel<List<ContributorModel?>>> getContributors({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  });
}

class ContributorRepositoryImpl implements ContributorRepository {
  final ContributorRemoteDataSource campaignRemoteDataSource;
  final NetworkInfo networkInfo;

  ContributorRepositoryImpl({
    required this.campaignRemoteDataSource,
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
            await campaignRemoteDataSource.getContributors(
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
