import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../data/models/return_value_model.dart';
import '../../../data/repositories/wallet_repository.dart';

part 'wallet_state.dart';

typedef Future<ReturnValueModel<Wallet>> _WalletRepositoryChooser();

class WalletCubit extends Cubit<WalletState> {
  WalletCubit({
    required this.walletRepository,
  }) : super(WalletInitial());

  final WalletRepository walletRepository;

  Future<ReturnValueModel<Wallet>> importWallet({
    required String password,
    required File file,
  }) async {
    return await _wallet(
      walletRepositoryChooser: () => walletRepository.importWallet(
        password: password,
        file: file,
      ),
    );
  }

  Future<ReturnValueModel<Wallet>> login({
    required String password,
  }) async {
    return await _wallet(
      walletRepositoryChooser: () => walletRepository.login(
        password: password,
      ),
    );
  }

  Future<ReturnValueModel<Wallet>> _wallet({
    required _WalletRepositoryChooser walletRepositoryChooser,
  }) async {
    final ReturnValueModel<Wallet> result = await walletRepositoryChooser();

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
