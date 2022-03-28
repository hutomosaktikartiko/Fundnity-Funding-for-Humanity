import 'package:web3dart/web3dart.dart';

import '../../../../core/models/return_value_model.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../shared/config/label_config.dart';
import '../datasources/deployed_contract_local_data_source.dart';

abstract class DeployedContractRepository {
  Future<ReturnValueModel<DeployedContract>> getDeployedContract({
    required String contractName,
    required String contractAddress,
    required String contractLocalUrl,
  });
}

class DeployedContractRepositoryImpl implements DeployedContractRepository {
  final NetworkInfo networkInfo;
  final DeployedContractLocalDataSource deployedContractLocalDataSource;

  DeployedContractRepositoryImpl({
    required this.deployedContractLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<ReturnValueModel<DeployedContract>> getDeployedContract({
    required String contractName,
    required String contractAddress,
    required String contractLocalUrl,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final DeployedContract result =
            await deployedContractLocalDataSource.getDeployedContract(
          contractAddress: contractAddress,
          contractLocalUrl: contractLocalUrl,
          contractName: contractName,
        );

        return ReturnValueModel(
          isSuccess: true,
          value: result,
        );
      } catch (error) {
        return ReturnValueModel(message: error.toString());
      }
    } else {
      return ReturnValueModel(
        message: LabelConfig.noInternet,
      );
    }
  }
}
