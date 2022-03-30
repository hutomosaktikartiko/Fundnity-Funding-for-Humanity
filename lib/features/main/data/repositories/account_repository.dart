import 'package:web3dart/web3dart.dart';

import '../../../../core/models/return_value_model.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../shared/config/label_config.dart';
import '../datasources/account_remote_data_balance.dart';

abstract class AccountRepository {
  Future<ReturnValueModel<EtherAmount>> getBalance({
    required EthereumAddress address,
    required Web3Client web3client,
  });
}

class AccountRepositoryImpl implements AccountRepository {
  final NetworkInfo networkInfo;
  final AccountRemoteDataSource accountRemoteDataSource;

  AccountRepositoryImpl({
    required this.networkInfo,
    required this.accountRemoteDataSource,
  });

  @override
  Future<ReturnValueModel<EtherAmount>> getBalance({
    required EthereumAddress address,
    required Web3Client web3client,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final EtherAmount balance = await accountRemoteDataSource.getBalance(
          address: address,
          web3client: web3client,
        );

        return ReturnValueModel(
          isSuccess: true,
          value: balance,
        );
      } catch (error) {
        return ReturnValueModel(message: error.toString());
      }
    } else {
      return ReturnValueModel(message: LabelConfig.noInternet);
    }
  }
}