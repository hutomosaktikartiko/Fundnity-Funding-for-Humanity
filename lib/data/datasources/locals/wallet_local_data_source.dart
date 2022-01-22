import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:crowdfunding/core/utils/preferences.dart';
import 'package:web3dart/web3dart.dart';

abstract class WalletLocalDataSource {
  // Create wallet (input password and generate random privateKey)
  // Future<Wallet> createWallet({required String password});

  // Import Wallet json (json file and password)
  Future<Wallet> importWallet({
    required String password,
    required File file,
  });

  // If local wallet is exist
  // login with password
  Future<Wallet> login({required String password});
}

class WalletLocalDataSourceImpl implements WalletLocalDataSource {
  final Preferences preferences;

  WalletLocalDataSourceImpl({
    required this.preferences,
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

      return result;
    } catch (error) {
      throw error;
    }
  }

  // Future<Wallet> createWallet({required String password}) async {
  //   try {
  //     // Generate a new key randomly
  //     Random random = new Random.secure();
  //     print("Random $random");
  //     // Create Ceredentials by random
  //     Credentials credentials = EthPrivateKey.createRandom(random);
  //     print("Credentials $credentials");
  //     // Create wallet
  //     Wallet wallet = Wallet.createNew(
  //         EthPrivateKey.fromHex((await credentials.extractAddress()).hex),
  //         password,
  //         random);
  //     print("Wallet $wallet");

  //     return wallet;
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  @override
  Future<Wallet> login({required String password}) async {
    try {
      // Get wallet from local as String
      final String? wallet = preferences.wallet;

      // If wallet == null
      // throw error
      if (wallet == null) throw "Data wallet tidak ditemukan";

      // Check wallet password
      final Wallet result = Wallet.fromJson(wallet, password,);

      return result;
    } catch (error) {
      throw error;
    }
  }
}
