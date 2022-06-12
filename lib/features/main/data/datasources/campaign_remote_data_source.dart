import 'package:cloud_firestore/cloud_firestore.dart' as firebase;
import 'package:web3dart/web3dart.dart';

import '../../../../shared/config/label_config.dart';
import '../models/campaign_firestore_model.dart';
import '../models/campaign_model.dart';
import '../models/history_model.dart';

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

  // Get My Campaigns
  Future<List<CampaignFirestoreModel>> getMyCampaigns({
    required EthereumAddress? address,
  });

  // Claim Campaign
  Future<String> claimCampaign({
    required DeployedContract contract,
    required Web3Client web3Client,
    required EthPrivateKey walletPrivateKey,
    required CampaignModel campaign,
  });
}

class CampaignRemoteDataSourceImpl implements CampaignRemoteDataSource {
  final firebase.FirebaseFirestore firestore;

  CampaignRemoteDataSourceImpl({
    required this.firestore,
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

      print("result $result");
      print("result ${result[10].runtimeType}");
      print("result ${result[10]}");

      return CampaignModel.fromJson(result);
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<List<CampaignFirestoreModel>> getMyCampaigns({
    required EthereumAddress? address,
  }) async {
    try {
      final firebase.QuerySnapshot result = await firestore
          .collection('users')
          .doc(address.toString())
          .collection('campaigns')
          .get();

      List results = result.docs;

      return results
          .map((doc) => CampaignFirestoreModel.fromJson(doc.data()))
          .toList();
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<String> claimCampaign({
    required DeployedContract contract,
    required Web3Client web3Client,
    required EthPrivateKey walletPrivateKey,
    required CampaignModel campaign,
  }) async {
    try {
      final String result = await web3Client.sendTransaction(
        walletPrivateKey,
        Transaction.callContract(
          contract: contract,
          function: contract.function('deliverCampaign'),
          parameters: [],
          maxGas: 1500000,
        ),
        chainId: 4,
      );

      print("========= SUCCESS CLAIM CAMPAIGN ========");
      print(result);

      // Save history transaction to firestore
      _saveToFirestore(
        address: walletPrivateKey.address.toString(),
        transactionHash: result,
        campaignTitle: campaign.title,
        amount: campaign.balance.toString(),
      );

      return LabelConfig.claimCampaignPending;
    } catch (error) {
      print("========= FAILED CLAIM CAMPAIGN ========");
      print(error);

      throw error;
    }
  }

   void _saveToFirestore({
    required String? address,
    required String? transactionHash,
    required String? campaignTitle,
    required String? amount,
  }) {
    firestore
        .collection('users')
        .doc(address)
        .collection('history')
        .doc(transactionHash)
        .set(
          HistoryModel(
            category: 3,
            amount: amount,
            campaignTitle: campaignTitle,
            transactionHash: transactionHash,
            timestamp: DateTime.now().millisecondsSinceEpoch,
          ).toJson(),
        );
  }
}
