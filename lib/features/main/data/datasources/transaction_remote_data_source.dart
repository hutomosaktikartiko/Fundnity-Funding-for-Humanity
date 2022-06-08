import 'package:dio/dio.dart';

import '../../../../shared/config/keys_config.dart';
import '../../../../shared/config/urls_config.dart';
import '../models/transaction_status_model.dart';

abstract class TransactionRemoteDataSource {
  Future<TransactionStatusModel> getTransactionStatus({
    required String? transactionHash,
  });
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final Dio dio;

  TransactionRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<TransactionStatusModel> getTransactionStatus({
    required String? transactionHash,
  }) async {
    try {
      final result = await dio.get(
        UrlsConfig.etherScanRinkeby,
        queryParameters: {
          "module": "transaction",
          "action": "getstatus",
          "txhash": transactionHash,
          "apiKey": KeysConfig.etherScanApiKey,
        },
      );

      if (result.data['result'] == null) throw 'No transaction found';

      return TransactionStatusModel.fromJson(result.data['result']);
    } on DioError catch (error) {
      throw error;
    }
  }
}
