import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

abstract class WalletLocalDataSource {
  Future<Wallet> getWallets({required String password});
}

class WalletLocalDataSourceImpl implements WalletLocalDataSource {
  @override
  Future<Wallet> getWallets({required String password}) async {
    try {
      final String wallet = await rootBundle.loadString("assets/wallet/akun_2.json");

      final Wallet result = Wallet.fromJson(wallet, password);

      return result;
    } catch (error) {
      throw error;
    }
  }
}