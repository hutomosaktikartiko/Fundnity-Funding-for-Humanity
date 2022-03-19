import 'dart:io';

import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../../models/campaign_model.dart';

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

  // Create Campaign -> Terhubung dengan
  Future<String> createCampaign({
    required CampaignModel campaign,
    required Web3Client web3client,
  });

  // Upload image to Pinata
  Future<String> uploadImage({
    required File image,
    required Web3Client web3client,
  });

  // Get Total Campaign witdraw request

  // Get Campaign Summary
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

  @override
  Future<String> createCampaign({
    required CampaignModel campaign,
    required Web3Client web3client,
  }) async {
    try {
      return "Pembuatan campaign sedang diproses, silahkan tunggu beberapa saat";
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<String> uploadImage({
    required File image,
    required Web3Client web3client,
  }) async {
    try {

      return "Berhasil mengupload gambar";
    } catch (error) {
      throw error;
    }
  }
}
