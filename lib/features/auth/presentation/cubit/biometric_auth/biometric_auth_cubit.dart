import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';

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
}
