import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../core/models/return_value_model.dart';
import '../../../data/repositories/auth_repository.dart';

part 'wallet_state.dart';

typedef Future<ReturnValueModel<Wallet>> _AuthRepositoryChooser();

class WalletCubit extends Cubit<WalletState> {
  WalletCubit({
    required this.authRepository,
  }) : super(WalletInitial());

  final AuthRepository authRepository;

  Future<ReturnValueModel<Wallet>> importWallet({
    required String password,
    required File file,
  }) async {
    return await _wallet(
      authRepositoryChooser: () => authRepository.importWallet(
        password: password,
        file: file,
      ),
    );
  }

  Future<ReturnValueModel<Wallet>> login({
    required String password,
  }) async {
    return await _wallet(
      authRepositoryChooser: () => authRepository.login(
        password: password,
      ),
    );
  }

  Future<ReturnValueModel<Wallet>> createWallet({
    required String password,
  }) async {
    return await _wallet(
      authRepositoryChooser: () => authRepository.createWallet(
        password: password,
      ),
    );
  }

  Future<ReturnValueModel<Wallet>> _wallet({
    required _AuthRepositoryChooser authRepositoryChooser,
  }) async {
    final ReturnValueModel<Wallet> result = await authRepositoryChooser();

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
