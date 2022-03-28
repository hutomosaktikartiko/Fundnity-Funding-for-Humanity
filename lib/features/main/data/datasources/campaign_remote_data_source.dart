import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../models/campaign_model.dart';

abstract class CampaignRemoteDataSource {
  // Get All Campaign
  Future<List<dynamic>> getAllAddressCampaigns({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  });

  // Get Campaign Detail
  Future<CampaignModel> getCampaignDetail({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  });
}

class CampaignRemoteDataSourceImpl implements CampaignRemoteDataSource {
  final Client client;

  CampaignRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<dynamic>> getAllAddressCampaigns({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  }) async {
    try {
      final List<dynamic> result = await web3Client.call(
        contract: deployedContract,
        function: deployedContract.function('getCampaigns'),
        params: [],
      );

      return result[0];
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<CampaignModel> getCampaignDetail({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  }) async {
    try {
      final List<dynamic> result = await web3Client.call(
        contract: deployedContract,
        function: deployedContract.function("getCampaign"),
        params: [],
      );

      return CampaignModel.fromJson(result);
    } catch (error) {
      throw error;
    }
  }
}