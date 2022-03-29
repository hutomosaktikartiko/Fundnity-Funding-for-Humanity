import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

abstract class DeployedContractLocalDataSource {
  Future<DeployedContract> getDeployedContract({
    required dynamic contractAddress,
    required String contractLocalUrl,
    required String contractName,
  });
}

class DeplotedContractLocalDataSourceImpl
    implements DeployedContractLocalDataSource {
  @override
  Future<DeployedContract> getDeployedContract({
    required dynamic contractAddress,
    required String contractLocalUrl,
    required String contractName,
  }) async {
    try {
      final String fileAbi = await rootBundle.loadString(contractLocalUrl);
      final DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(fileAbi, contractName),
        contractAddress,
      );
      
      return contract;
    } catch (error) {
      throw error;
    }
  }
}
