import 'dart:io';
import 'package:web3dart/web3dart.dart';

abstract class WalletLocalDataSource {
  // Create wallet (input password and generate random privateKey)

  // Import Wallet json (json file and password)
  Future<Wallet> importWallet({
    required String password,
    required File file,
  });

  // If local wallet is exist
  // login with password
  // Future<Wallet> login({required String password});
}

class WalletLocalDataSourceImpl implements WalletLocalDataSource {
  Future<Wallet> importWallet({
    required String password,
    required File file,
  }) async {
    try {
      final String wallet = File(file.path).readAsStringSync();
      final Wallet result = Wallet.fromJson(wallet, password,);

      // TODO => Save json file to local device
      // if result != null
      // Save json file to local

      return result;
    } catch (error) {
      throw error;
    }
  }
}
