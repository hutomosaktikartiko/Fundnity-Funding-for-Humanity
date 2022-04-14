import 'package:web3dart/web3dart.dart';

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
    required String walletPrivateKey,
  });
}

class ContributeRemoteDataSourceImpl implements ContributeRemoteDataSource {
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

   @override
  Future<String> contribute({
    required DeployedContract deployedContract,
    required Web3Client web3Client,
    required String walletPrivateKey,
    required BigInt amount,
  }) async {
    print(amount);
    print(deployedContract.abi.name);
    print(walletPrivateKey);
    try {
      final String result = await web3Client.sendTransaction(
        EthPrivateKey.fromHex(walletPrivateKey),
        Transaction.callContract(
          contract: deployedContract,
          function: deployedContract.function('contribute'),
          parameters: [],
          value: EtherAmount.fromUnitAndValue(EtherUnit.gwei, amount),
          maxGas: 1500000,
        ),
        chainId: 4,
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
}
