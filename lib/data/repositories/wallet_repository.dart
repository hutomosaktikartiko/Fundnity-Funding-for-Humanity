import 'package:web3dart/web3dart.dart';

import '../../core/config/label_config.dart';
import '../../core/network/network_info.dart';
import '../datasources/locals/wallet_local_data_source.dart';
import '../models/return_value_model.dart';

abstract class WalletRepository {
  Future<ReturnValueModel<Wallet>> getWallets({required String password});
}

class WalletRepositoryImpl implements WalletRepository {
  final WalletLocalDataSource walletLocalDataSource;
  final NetworkInfo networkInfo;

  WalletRepositoryImpl({
    required this.networkInfo,
    required this.walletLocalDataSource,
  });

  @override
  Future<ReturnValueModel<Wallet>> getWallets({
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final Wallet wallet =
            await walletLocalDataSource.getWallets(password: password);

        return ReturnValueModel(
          isSuccess: true,
          value: wallet,
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
