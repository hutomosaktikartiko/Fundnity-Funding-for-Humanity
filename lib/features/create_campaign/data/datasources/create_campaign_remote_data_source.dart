import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart' as firebase;
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

import '../../../../shared/config/keys_config.dart';
import '../../../../shared/config/urls_config.dart';
import '../../../main/data/models/history_model.dart';
import '../models/campaign_firestore_model.dart';
import '../models/create_campaign_model.dart';
import '../models/ipfs_upload_model.dart';

abstract class CreateCampaignRemoteDataSource {
  Future<String> createCampaign({
    required CreateCampaignModel campaign,
    required DeployedContract contract,
    required Web3Client web3Client,
    required EthPrivateKey walletPrivateKey,
  });
  Future<IpfsUploadModel> uploadImage({
    required File image,
  });
}

class CreateCampaignRemoteDataSourceImpl
    implements CreateCampaignRemoteDataSource {
  final firebase.FirebaseFirestore firestore;
  final http.Client client;
  final Dio dio;

  CreateCampaignRemoteDataSourceImpl({
    required this.client,
    required this.dio,
    required this.firestore,
  });

  @override
  Future<String> createCampaign({
    required CreateCampaignModel campaign,
    required DeployedContract contract,
    required Web3Client web3Client,
    required EthPrivateKey walletPrivateKey,
  }) async {
    try {
      final String result = await web3Client.sendTransaction(
        walletPrivateKey,
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
          maxGas: 1500000,
        ),
        chainId: 4,
      );

      _saveToFirestore(
        address: walletPrivateKey.address.toString(),
        transactionHash: result,
        campaign: campaign,
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
              'Authorization':
                  'Basic ${base64.encode(utf8.encode(KeysConfig.infuraIPFSPrivateKey))}',
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

  void _saveToFirestore({
    required String? address,
    required String? transactionHash,
    required CreateCampaignModel? campaign,
  }) {
    firestore
        .collection('users')
        .doc(address)
        .collection('history')
        .doc(transactionHash)
        .set(
          HistoryModel(
            category: 2,
            campaignTitle: campaign?.title,
            transactionHash: transactionHash,
          ).toJson(),
        );
     firestore
        .collection('users')
        .doc(address)
        .collection('campaigns')
        .doc(transactionHash)
        .set(
          CampaignFirestoreModel(
            image: campaign?.image,
            title: campaign?.title,
            target: campaign?.target.toString(),
            description: campaign?.description,
            creatorAddress: address,
            startDate: DateTime.now().millisecondsSinceEpoch,
            endDate: campaign?.endDate?.toInt(),
          ).toJson(),
        );
  }
}
