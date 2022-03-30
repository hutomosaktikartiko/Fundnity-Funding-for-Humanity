import 'package:web3dart/web3dart.dart';

abstract class AccountRemoteDataSource {
  Future<EtherAmount> getBalance({
    required EthereumAddress address,
    required Web3Client web3client,
  });
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  @override
  Future<EtherAmount> getBalance({
    required EthereumAddress address,
    required Web3Client web3client,
  }) async {
    try {
      final EtherAmount balance = await web3client.getBalance(address);
      return balance;
    } catch (error) {
      throw error;
    }
  }
}
