import 'package:web3dart/web3dart.dart';

abstract class EthereumRemoteDataSource {
  Future<EtherAmount> getBalance({required String address});
}

class EthereumRemoteDataSourceImpl implements EthereumRemoteDataSource {
  final Web3Client web3client;

  EthereumRemoteDataSourceImpl({
    required this.web3client,
  });

  @override
  Future<EtherAmount> getBalance({required String address}) async {
    return await web3client.getBalance(EthereumAddress.fromHex(address));
  }
}
