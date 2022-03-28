import 'dart:io';

import 'package:web3dart/web3dart.dart';

import '../../../../core/models/return_value_model.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../shared/config/label_config.dart';
import '../datasources/auth_local_data_source.dart';

typedef Future<Wallet> _AuthLocalDataSourceChooser();

abstract class AuthRepository {
  Future<ReturnValueModel<Wallet>> importWallet({
    required String password,
    required File file,
  });
  Future<ReturnValueModel<Wallet>> login({required String password});
  Future<ReturnValueModel<Wallet>> createWallet({required String password});
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource authLocalDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.networkInfo,
    required this.authLocalDataSource,
  });

  @override
  Future<ReturnValueModel<Wallet>> importWallet({
    required String password,
    required File file,
  }) async {
    return await _wallet(
      authLocalDataSourceChooser: () => authLocalDataSource.importWallet(
        password: password,
        file: file,
      ),
    );
  }

  @override
  Future<ReturnValueModel<Wallet>> login({required String password}) async {
    return await _wallet(
      authLocalDataSourceChooser: () => authLocalDataSource.login(
        password: password,
      ),
    );
  }

  @override
  Future<ReturnValueModel<Wallet>> createWallet({
    required String password,
  }) async {
    return await _wallet(
      authLocalDataSourceChooser: () => authLocalDataSource.createWallet(
        password: password,
      ),
    );
  }

  Future<ReturnValueModel<Wallet>> _wallet({
    required _AuthLocalDataSourceChooser authLocalDataSourceChooser,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final Wallet result = await authLocalDataSourceChooser();

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
