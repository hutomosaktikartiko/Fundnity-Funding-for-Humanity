import 'dart:io';

import 'package:web3dart/web3dart.dart';

import '../../core/config/label_config.dart';
import '../../core/network/network_info.dart';
import '../datasources/locals/wallet_local_data_source.dart';
import '../models/return_value_model.dart';

typedef Future<Wallet> _WalletLocalDataSourceChooser();

abstract class WalletRepository {
  Future<ReturnValueModel<Wallet>> importWallet({
    required String password,
    required File file,
  });
  Future<ReturnValueModel<Wallet>> login({required String password});
  Future<ReturnValueModel<Wallet>> createWallet({required String password});
}

class WalletRepositoryImpl implements WalletRepository {
  final WalletLocalDataSource walletLocalDataSource;
  final NetworkInfo networkInfo;

  WalletRepositoryImpl({
    required this.networkInfo,
    required this.walletLocalDataSource,
  });

  @override
  Future<ReturnValueModel<Wallet>> importWallet({
    required String password,
    required File file,
  }) async {
    return await _wallet(
      walletLocalDataSourceChooser: () => walletLocalDataSource.importWallet(
        password: password,
        file: file,
      ),
    );
  }

  @override
  Future<ReturnValueModel<Wallet>> login({required String password}) async {
    return await _wallet(
      walletLocalDataSourceChooser: () => walletLocalDataSource.login(
        password: password,
      ),
    );
  }

  @override
  Future<ReturnValueModel<Wallet>> createWallet({
    required String password,
  }) async {
    return await _wallet(
      walletLocalDataSourceChooser: () => walletLocalDataSource.createWallet(
        password: password,
      ),
    );
  }

  Future<ReturnValueModel<Wallet>> _wallet({
    required _WalletLocalDataSourceChooser walletLocalDataSourceChooser,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final Wallet result = await walletLocalDataSourceChooser();

        return ReturnValueModel(
          isSuccess: true,
          value: result,
        );
      } catch (error) {
        return ReturnValueModel(message: error.toString());
      }
    } else {
      return ReturnValueModel(message: LabelConfig.noInternet);
    }
  }
}
