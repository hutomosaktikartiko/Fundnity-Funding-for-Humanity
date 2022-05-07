import 'package:crowdfunding/features/main/data/models/transaction_receipt_model.dart';
import 'package:crowdfunding/shared/config/keys_config.dart';
import 'package:crowdfunding/shared/config/urls_config.dart';
import 'package:dio/dio.dart';

abstract class TransactionRemoteDataSource {
  Future<TransactionReceiptModel?> getTransactionReceipt({
    required String? transactionHash,
  });
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final Dio dio;

  TransactionRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<TransactionReceiptModel?> getTransactionReceipt({
    required String? transactionHash,
  }) async {
    try {
      final result = await dio.post(
        UrlsConfig.infuraRinkbeyProvider + KeysConfig.infuraEthereumProjectId,
        data: {
          "jsonrpc": "2.0",
          "method": "eth_getTransactionReceipt",
          "params": [
            transactionHash,
          ],
          "id": 1
        },
      );

      if (result.data['result'] == null) {
        return null;
      }

      return TransactionReceiptModel.fromJson(result.data['result']);
    } on DioError catch (error) {
      throw error;
    }
  }
}
