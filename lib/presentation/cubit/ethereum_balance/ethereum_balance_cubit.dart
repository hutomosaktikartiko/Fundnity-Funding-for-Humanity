import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../data/models/return_value_model.dart';
import '../../../data/repositories/ethereum_repository.dart';

part 'ethereum_balance_state.dart';

class EthereumBalanceCubit extends Cubit<EthereumBalanceState> {
  EthereumBalanceCubit({
    required this.ethereumRepository,
  }) : super(EthereumBalanceInitial());

  final EthereumRepository ethereumRepository;

  Future<ReturnValueModel<bool>> getBalance({
    required String address,
  }) async {
    final ReturnValueModel<EtherAmount> result =
        await ethereumRepository.getBalance(address: address);

    if (result.isSuccess) {
      emit(EthereumBalanceLoaded(etherAmount: result.value));
    } else {
      emit(EthereumBalanceLoadingFailure(message: result.message));
    }

    return ReturnValueModel(
      isSuccess: result.isSuccess,
      message: result.message,
    );
  }
}
