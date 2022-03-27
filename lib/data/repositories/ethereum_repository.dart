import 'package:web3dart/web3dart.dart';

import '../../shared/config/label_config.dart';
import '../../core/utils/network_info.dart';
import '../datasources/remotes/ethereum_remote_data_source.dart';
import '../models/return_value_model.dart';

abstract class EthereumRepository {
  Future<ReturnValueModel<EtherAmount>> getBalance({
    required String address,
  });
}

class EthereumRepositoryImpl implements EthereumRepository {
  final EthereumRemoteDataSource ethereumRemoteDataSource;
  final NetworkInfo networkInfo;

  EthereumRepositoryImpl({
    required this.ethereumRemoteDataSource,
    required this.networkInfo,
  });

  Future<ReturnValueModel<EtherAmount>> getBalance({
    required String address,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final EtherAmount result =
            await ethereumRemoteDataSource.getBalance(address: address);

        return ReturnValueModel(
          isSuccess: true,
          value: result,
        );
      } catch (error) {
        return ReturnValueModel(
          message: error.toString(),
        );
      }
    } else {
      return ReturnValueModel(
        message: LabelConfig.noInternet,
      );
    }
  }
}
