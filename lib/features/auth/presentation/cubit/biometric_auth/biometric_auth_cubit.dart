import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../../core/models/return_value_model.dart';

part 'biometric_auth_state.dart';

class BiometricAuthCubit extends Cubit<BiometricAuthState> {
  BiometricAuthCubit({
    required this.localAuth,
  }) : super(BiometricAuthInitial());

  final LocalAuthentication localAuth;

  Future<void> checkAuth() async {
    emit(BiometricAuthLoading());
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;

    if (canCheckBiometrics) {
      List<BiometricType> availableBiometrics =
          await localAuth.getAvailableBiometrics();

      if (availableBiometrics.isNotEmpty) {
        if (availableBiometrics.contains(BiometricType.fingerprint)) {
          emit(BiometricAuthSuccess(biometricType: BiometricType.fingerprint));
        } else {
          emit(BiometricAuthNotAvailable());
        }
      } else {
        emit(BiometricAuthNotAvailable());
      }
    }
  }

  Future<ReturnValueModel> fingerprintAuth() async {
    try {
      final bool didAuthenticate = await localAuth.authenticate(
        localizedReason: "Login using your biomteric credential",
        useErrorDialogs: true,
        stickyAuth: true,
        biometricOnly: true,
        androidAuthStrings: AndroidAuthMessages(
          cancelButton: 'Use PIN',
          signInTitle: "Crowdfunding Biometric Login",
        ),
      );

      if (didAuthenticate) {
        return ReturnValueModel(
          isSuccess: didAuthenticate,
          message: "Fingerprint Authentication Successful",
        );
      } else {
        return ReturnValueModel(
          isSuccess: didAuthenticate,
          message: "Fingerprint Authentication Failed",
        );
      }
    } on PlatformException catch (e) {
      return ReturnValueModel(
        message: e.message,
      );
    }
  }
}
