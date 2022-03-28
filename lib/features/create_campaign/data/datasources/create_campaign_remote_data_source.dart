import 'dart:io';

import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../models/create_campaign_model.dart';

abstract class CreateCampaignRemoteDataSource {
  // Create Campaign -> Terhubung dengan
  Future<String> createCampaign({
    required CreateCampaignModel campaign,
    required DeployedContract contract,
    required Web3Client web3Client,
  });

  // Upload image to Pinata
  Future<String> uploadImage({
    required File image,
  });
}

class CreateCampaignRemoteDataSourceImpl
    implements CreateCampaignRemoteDataSource {
  final Client client;

  CreateCampaignRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<String> createCampaign({
    required CreateCampaignModel campaign,
    required DeployedContract contract,
    required Web3Client web3Client,
  }) async {
    try {
      // TODO: Connect to infura to Create Campaign
      return "Pembuatan campaign sedang diproses, silahkan tunggu beberapa saat";
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<String> uploadImage({
    required File image,
  }) async {
    try {
      // TODO: Upload image to IPFS
      return "Berhasil mengupload gambar";
    } catch (error) {
      throw error;
    }
  }
}
