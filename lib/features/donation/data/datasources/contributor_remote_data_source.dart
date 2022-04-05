import 'package:web3dart/web3dart.dart';

import '../models/contributor_model.dart';

abstract class ContributorRemoteDataSource {
  Future<List<ContributorModel?>> getContributors({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  });
}

class ContributorRemoteDataSourceImpl implements ContributorRemoteDataSource {
  @override
  Future<List<ContributorModel?>> getContributors({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  }) async {
    try {
      final List<dynamic> result = await web3Client.call(
        contract: deployedContract,
        function: deployedContract.function("getContributors"),
        params: [],
      );

      if (result[0].length < 1) {
        return [];
      }

      return result[0]
          .map((contributor) => ContributorModel.fromJson(contributor))
          .toList();
    } catch (error) {
      throw error;
    }
  }
}
