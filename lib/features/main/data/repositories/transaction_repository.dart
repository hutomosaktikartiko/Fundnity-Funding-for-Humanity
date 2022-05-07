import '../../../../core/models/return_value_model.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../shared/config/label_config.dart';
import '../datasources/transaction_remote_data_source.dart';
import '../models/transaction_receipt_model.dart';

abstract class TransactionRepository {
  Future<ReturnValueModel<TransactionReceiptModel?>> getTransactionReceipt({
    required String? transactionHash,
  });
}

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource transactionRemoteDataSource;
  final NetworkInfo networkInfo;

  TransactionRepositoryImpl({
    required this.transactionRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<ReturnValueModel<TransactionReceiptModel?>> getTransactionReceipt({
    required String? transactionHash,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final TransactionReceiptModel? transactionReceipt =
            await transactionRemoteDataSource.getTransactionReceipt(
          transactionHash: transactionHash,
        );

        return ReturnValueModel(
          isSuccess: true,
          value: transactionReceipt,
        );
      } catch (error) {
        return ReturnValueModel(
          message: error.toString(),
        );
      }
    } else {
      return ReturnValueModel(message: LabelConfig.noInternet);
    }
  }
}
