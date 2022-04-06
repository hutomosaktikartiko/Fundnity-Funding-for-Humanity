import 'package:dio/dio.dart';

import '../../../../shared/config/keys_config.dart';
import '../../../../shared/config/urls_config.dart';
import '../models/gas_estimation_time_model.dart';
import '../models/gas_tracker_model.dart';

abstract class GasRemoteDataSource {
  Future<GasTrackerModel> getGasTracker();
  Future<GasEstimationTimeModel> getGasEstimationTime({
    required String? gasPriceInWei,
  });
}

class GasRemoteDataSourceImpl implements GasRemoteDataSource {
  final Dio dio;

  GasRemoteDataSourceImpl({required this.dio});

  @override
  Future<GasTrackerModel> getGasTracker() async {
    try {
      final response = await dio.get(
          "${UrlsConfig.etherScan}?module=gastracker&action=gasoracle&apikey=${KeysConfig.etherScanApiKey}");
      
      return GasTrackerModel.fromJson(response.data['result']);
    } on DioError catch (error) {
      throw error;
    }
  }

  @override
  Future<GasEstimationTimeModel> getGasEstimationTime({
    required String? gasPriceInWei,
  }) async {
    try {
      final response = await dio.get(
          "${UrlsConfig.etherScan}?module=gastracker&action=gasestimate&gasprice=$gasPriceInWei&apikey=${KeysConfig.etherScanApiKey}");
      
      return GasEstimationTimeModel.fromJson(response.data);
    } on DioError catch (error) {
      throw error;
    }
  }
}
