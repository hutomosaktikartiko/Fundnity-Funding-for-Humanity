import 'package:cloud_firestore/cloud_firestore.dart' as firebase;
import 'package:web3dart/web3dart.dart';

import '../../../main/data/models/campaign_model.dart';
import '../../../main/data/models/history_model.dart';
import '../models/contributor_model.dart';

abstract class ContributeRemoteDataSource {
  Future<List<ContributorModel?>> getContributors({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
  });
  Future<String> contribute({
    required BigInt amount,
    required DeployedContract deployedContract,
    required Web3Client web3Client,
    required EthPrivateKey walletPrivateKey,
    required CampaignModel? campaign,
  });
}

class ContributeRemoteDataSourceImpl implements ContributeRemoteDataSource {
  final firebase.FirebaseFirestore firestore;

  ContributeRemoteDataSourceImpl({
    required this.firestore,
  });

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

      if (result.length < 1) {
        return [];
      }

      List<ContributorModel> contributors = [];

      if (result[0] is List) {
        for (int i = 0; i < result[0].length; i++) {
          contributors.add(ContributorModel(
              contributor: result[0][i], amount: result[1][i]));
        }
      } else {
        contributors.add(ContributorModel.fromJson(result));
      }

      return contributors;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<String> contribute({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
    required EthPrivateKey walletPrivateKey,
    required BigInt amount,
    required CampaignModel? campaign,
  }) async {
    try {
      final String result = await web3Client.sendTransaction(
        walletPrivateKey,
        Transaction.callContract(
          contract: deployedContract,
          function: deployedContract.function('contribute'),
          parameters: [],
          value: EtherAmount.fromUnitAndValue(EtherUnit.gwei, amount),
          maxGas: 1500000,
        ),
        chainId: 4,
      );

      // Save history transaction to firestore
      _saveToFirestore(
        address: walletPrivateKey.address.toString(),
        transactionHash: result,
        amount: amount.toString(),
        campaignTitle: campaign?.title,
      );

      print("========= SUCCESS DONATION ========");
      print(result);

      return result;
    } catch (e) {
      print("========= FAILED DONATION ========");
      print(e);
      throw e;
    }
  }

  void _saveToFirestore({
    required String? address,
    required String? transactionHash,
    required String? campaignTitle,
    required String? amount,
  }) {
    // TODO: Save timestamp donate
    firestore
        .collection('users')
        .doc(address)
        .collection('history')
        .doc(transactionHash)
        .set(
      HistoryModel(
        category: 1,
        amount: amount,
        campaignTitle: campaignTitle,
        transactionHash: transactionHash,
      ).toJson(),
    );
  }
}
