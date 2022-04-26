import '../../../../core/models/return_value_model.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../shared/config/label_config.dart';
import '../datasources/history_remote_data_srouce.dart';
import '../models/history_model.dart';

abstract class HistoryRepository {
  Future<ReturnValueModel<List<HistoryModel>>> getListHistory({
    required String? address,
  });
}

class HistoryRepositoryImpl implements HistoryRepository {
  final NetworkInfo networkInfo;
  final HistoryRemoteDataSource historyRemoteDataSource;

  HistoryRepositoryImpl({
    required this.networkInfo,
    required this.historyRemoteDataSource,
  });

  @override
  Future<ReturnValueModel<List<HistoryModel>>> getListHistory({
    required String? address,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final List<HistoryModel> history =
            await historyRemoteDataSource.getListHistory(address: address);

        return ReturnValueModel(
          isSuccess: true,
          value: history,
        );
      } catch (error) {
        return ReturnValueModel(
          message: error.toString(),
        );
      }
    } else {
      return ReturnValueModel(
        message: LabelConfig.noInternet,
      );
    }
  }
}
