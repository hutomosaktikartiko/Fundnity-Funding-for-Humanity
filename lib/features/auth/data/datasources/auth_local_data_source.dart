import 'dart:io';
import 'dart:math';

import 'package:web3dart/web3dart.dart';

import '../../../../core/utils/preferences_info.dart';
import '../../../../core/utils/secure_storage_info.dart';
import '../../../../shared/config/secure_storage_key.dart';

abstract class AuthLocalDataSource {
  // Create wallet (input password and generate random privateKey)
  Future<Wallet> createWallet({required String password});

  // Import Wallet json (json file and password)
  Future<Wallet> importWallet({
    required String password,
    required File file,
  });

  // If local wallet is exist
  // login with password
  Future<Wallet> login({required String password});
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final PreferencesInfo preferences;
  final SecureStorageInfo secureStorage;

  AuthLocalDataSourceImpl({
    required this.preferences,
    required this.secureStorage,
  });

  Future<Wallet> importWallet({
    required String password,
    required File file,
  }) async {
    try {
      // Get wallet data
      final String wallet = File(file.path).readAsStringSync();
      // Check wallet password
      final Wallet result = Wallet.fromJson(
        wallet,
        password,
      );

      // if result != null
      // Save json file to local
      preferences.wallet = wallet;
      // Save wallet password to local
      secureStorage.setValue(key: SecureStorageKey.password, value: password);

      return result;
    } catch (error) {
      throw error;
    }
  }

  Future<Wallet> createWallet({required String password}) async {
    try {
      // Generate a new key randomly
      Random random = new Random.secure();
      // Create Ceredentials by random
      Credentials credentials = EthPrivateKey.createRandom(random);
      // Create wallet
      Wallet wallet = Wallet.createNew(
        EthPrivateKey.fromHex((await credentials.extractAddress()).hex),
        password,
        random,
      );

      // Save wallet json to local
      preferences.wallet = wallet.toJson();
      // Save wallet password to local
      secureStorage.setValue(key: SecureStorageKey.password, value: password);
      // Delete local pin
      secureStorage.delete(key: SecureStorageKey.pin);

      return wallet;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<Wallet> login({required String password}) async {
    try {
      // Get wallet from local as String
      final String? wallet = preferences.wallet;

      // If wallet == null
      // throw error
      if (wallet == null) throw "Data wallet tidak ditemukan";

      // Check wallet password
      final Wallet result = Wallet.fromJson(
        wallet,
        password,
      );

      return result;
    } catch (error) {
      throw error;
    }
  }
}
