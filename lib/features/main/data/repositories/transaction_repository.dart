import '../../../../core/models/return_value_model.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../shared/config/label_config.dart';
import '../datasources/transaction_remote_data_source.dart';
import '../models/transaction_status_model.dart';

abstract class TransactionRepository {
  Future<ReturnValueModel<TransactionStatusModel>> getTransactionStatus({
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
  Future<ReturnValueModel<TransactionStatusModel>> getTransactionStatus({
    required String? transactionHash,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final TransactionStatusModel transactionStatus =
            await transactionRemoteDataSource.getTransactionStatus(
          transactionHash: transactionHash,
        );

        return ReturnValueModel(
          isSuccess: true,
          value: transactionStatus,
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
