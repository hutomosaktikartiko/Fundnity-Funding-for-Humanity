import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/models/return_value_model.dart';
import '../../../../../shared/extension/string_parsing.dart';
import '../../../data/models/gas_estimation_time_model.dart';
import '../../../data/models/gas_model.dart';
import '../../../data/models/gas_tracker_model.dart';
import '../../../data/repositories/gas_repository.dart';

part 'gas_tracker_state.dart';

class GasTrackerCubit extends Cubit<GasTrackerState> {
  GasTrackerCubit({
    required this.gasRepository,
  }) : super(GasTrackerInitial());

  final GasRepository gasRepository;

  Future<void> getGasTracker() async {
    emit(GasTrackerLoading());

    final ReturnValueModel<GasTrackerModel> result =
        await gasRepository.getGasTracker();

    if (result.isSuccess && result.value != null) {
      List<GasModel?> gasResults = await getGas(gasTracker: result.value!);

      if (gasResults.length > 0) {
        emit(GasTrackerLoaded(listGas: gasResults));
      } else {
        emit(GasTrackerLoadingFailure(message: "Failed to get gas data"));
      }
    } else {
      emit(GasTrackerLoadingFailure(message: result.message));
    }
  }

  Future<List<GasModel?>> getGas({
    required GasTrackerModel gasTracker,
  }) async {
    final List<GasModel?> result = await Future.wait([
      getGasEstimationTime(title: "😁 Low", gasPrice: gasTracker.safeGasPrice),
      getGasEstimationTime(title: "😀 Average", gasPrice: gasTracker.proposeGasPrice),
      getGasEstimationTime(title:"🙂 High", gasPrice: gasTracker.fastGasPrice),
    ]);

    return result;
  }

  Future<GasModel?> getGasEstimationTime({
    required String? gasPrice,
    required String title,
  }) async {
    if (gasPrice == null) return null;
    final ReturnValueModel<GasEstimationTimeModel> low =
        await gasRepository.getGasEstimationTime(gasPriceInWei: gasPrice.stringGweiToWei());

    return GasModel(
      title: title,
      gasPriceInGwei: gasPrice,
      estimationTime: low.value?.timeInSecond,
    );
  }
}
