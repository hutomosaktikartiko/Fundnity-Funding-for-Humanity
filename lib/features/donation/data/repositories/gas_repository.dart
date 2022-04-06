import '../../../../core/models/return_value_model.dart';
import '../../../../core/utils/network_info.dart';
import '../../../../shared/config/label_config.dart';
import '../datasources/gas_remote_data_source.dart';
import '../models/gas_estimation_time_model.dart';
import '../models/gas_tracker_model.dart';

abstract class GasRepository {
  Future<ReturnValueModel<GasTrackerModel>> getGasTracker();
  Future<ReturnValueModel<GasEstimationTimeModel>> getGasEstimationTime({
    required String? gasPriceInWei,
  });
}

class GasRepositoryImpl implements GasRepository {
  final GasRemoteDataSource gasRemoteDataSource;
  final NetworkInfo networkInfo;

  GasRepositoryImpl({
    required this.gasRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<ReturnValueModel<GasTrackerModel>> getGasTracker() async {
    if (await networkInfo.isConnected) {
      try {
        final GasTrackerModel result =
            await gasRemoteDataSource.getGasTracker();
        return ReturnValueModel(
          isSuccess: true,
          value: result,
        );
      } catch (error) {
        return ReturnValueModel(message: error.toString());
      }
    } else {
      return ReturnValueModel(
        message: LabelConfig.noInternet,
      );
    }
  }

  @override
  Future<ReturnValueModel<GasEstimationTimeModel>> getGasEstimationTime({
    required String? gasPriceInWei,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final GasEstimationTimeModel result =
            await gasRemoteDataSource.getGasEstimationTime(gasPriceInWei: gasPriceInWei);
        return ReturnValueModel(
          isSuccess: true,
          value: result,
        );
      } catch (error) {
        return ReturnValueModel(message: error.toString());
      }
    } else {
      return ReturnValueModel(
        message: LabelConfig.noInternet,
      );
    }
  }
}
