import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../core/models/return_value_model.dart';
import '../../../data/repositories/account_repository.dart';

part 'account_balance_state.dart';

class AccountBalanceCubit extends Cubit<AccountBalanceState> {
  AccountBalanceCubit({
    required this.accountRepository,
  }) : super(AccountBalanceInitial());

  final AccountRepository accountRepository;

  Future<void> getBalance({
    required EthereumAddress address,
    required Web3Client web3client,
  }) async {
    emit(AccountBalanceLoading());

    final ReturnValueModel<EtherAmount> result =
        await accountRepository.getBalance(
      address: address,
      web3client: web3client,
    );

    if (result.isSuccess && result.value != null) {
      emit(AccountBalanceLoaded(balance: result.value!));
    } else {
      emit(AccountBalanceLoadingFailure(message: result.message));
    }
  }
}
