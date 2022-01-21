import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../data/models/return_value_model.dart';
import '../../../data/repositories/wallet_repository.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit({
    required this.walletRepository,
  }) : super(WalletInitial());

  final WalletRepository walletRepository;

  Future<ReturnValueModel<bool>> getWallets({required String password,}) async {
    final ReturnValueModel<Wallet> result = await walletRepository.getWallets(password: password);

    if (result.isSuccess && result.value != null) {
      emit(WalletLoaded(wallet: result.value!));
    } else {
      emit(WalletLoadingFailure(message: result.message));
    }

    return ReturnValueModel(
      isSuccess: result.isSuccess,
      message: result.message,
    );
  }
}
