import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

import '../../../../service_locator.dart';
import '../../../../shared/config/keys_config.dart';
import '../../../../shared/config/urls_config.dart';
import '../models/create_campaign_model.dart';
import '../models/ipfs_upload_model.dart';

abstract class CreateCampaignRemoteDataSource {
  Future<String> createCampaign({
    required CreateCampaignModel campaign,
    required DeployedContract contract,
    required Web3Client web3Client,
    required String walletPrivateKey,
  });
  Future<IpfsUploadModel> uploadImage({
    required File image,
  });
}

class CreateCampaignRemoteDataSourceImpl
    implements CreateCampaignRemoteDataSource {
  final http.Client client;
  final Dio dio;

  CreateCampaignRemoteDataSourceImpl({
    required this.client,
    required this.dio,
  });

  @override
  Future<String> createCampaign({
    required CreateCampaignModel campaign,
    required DeployedContract contract,
    required Web3Client web3Client,
    required String walletPrivateKey,
  }) async {
    try {
      final result = await web3Client.sendTransaction(
        EthPrivateKey.fromHex(walletPrivateKey),
        Transaction.callContract(
          contract: contract,
          function: contract.function('createCampaign'),
          parameters: [
            campaign.image,
            campaign.title,
            campaign.description,
            campaign.target,
            campaign.endDate
          ],
          maxGas: 500000,
        ),
        chainId: 3,
      );

      print("========= SUCCESS CREATE CAMPAIGN ========");
      print(result);

      return "Pembuatan campaign sedang diproses, silahkan tunggu beberapa saat";
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<IpfsUploadModel> uploadImage({
    required File image,
  }) async {
    try {
      final Response response = await dio.post(UrlsConfig.infuraIPFS + 'add?',
          data: FormData.fromMap({
            'file': await MultipartFile.fromFile(
              image.path,
              filename: image.path.split('/').last,
            ),
          }),
          queryParameters: {
            'pin': false,
            'cid-version': 1,
          },
          options: Options(
            headers: {
              'Authorization': 'Basic ${KeysConfig.infuraIPFSPrivateKey}',
            },
          ), onSendProgress: (received, total) {
        if (total != -1) {
          print(
              'Upload Image to IPFS ${(received / total * 100).toStringAsFixed(0)}%');
        }
      });

      print("========== SUCCESS UPLOAD IMAGE =========");
      print(response.data);
      print(response.data.runtimeType);

      return IpfsUploadModel.fromJson(response.data);
    } on DioError catch (error) {
      throw error;
    }
  }
}
