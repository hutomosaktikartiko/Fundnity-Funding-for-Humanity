import 'package:web3dart/web3dart.dart';

abstract class CampaignRemoteDataSource {
  // Get All Campaign
  Future<List<dynamic>> getAllCampaign({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  });

  // Create Campaign -> Terhubung dengan

  // Get Total Campaign witdraw request

  // Get Campaign Summary
}

class CampaignRemoteDataSourceImpl implements CampaignRemoteDataSource {
  @override
  Future<List<dynamic>> getAllCampaign({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  }) async {
    try {
      final List<dynamic> result = await web3Client.call(
        contract: deployedContract,
        function: deployedContract.function('getDeployedCampaigns'),
        params: [],
      );

      return result;
    } catch (error) {
      throw error;
    }
  }
}
