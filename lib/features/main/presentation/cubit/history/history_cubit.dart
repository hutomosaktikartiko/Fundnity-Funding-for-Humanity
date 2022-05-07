import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/models/return_value_model.dart';
import '../../../data/models/history_model.dart';
import '../../../data/repositories/history_repository.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit({
    required this.historyRepository,
  }) : super(HistoryInitial());

  final HistoryRepository historyRepository;

  Future<void> getListHistory({
    required String? address,
  }) async {
    emit(HistoryLoading());

    final ReturnValueModel<List<HistoryModel>> result =
        await historyRepository.getListHistory(address: address);

    if (result.isSuccess && result.value != null) {
      if ((result.value?.length ?? 0) > 0) {
        // TODO: Sort history by timestamp DESC in result.value from firebase
        emit(HistoryLoaded(history: result.value!));
      } else {
        emit(HistoryEmpty());
      }
    } else {
      emit(HistoryFailure(message: result.message));
    }
  }
}
