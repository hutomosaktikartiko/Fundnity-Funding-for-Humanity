part of 'biometric_auth_cubit.dart';

abstract class BiometricAuthState extends Equatable {
  const BiometricAuthState();

  @override
  List<Object> get props => [];
}

class BiometricAuthInitial extends BiometricAuthState {}

class BiometricAuthLoading extends BiometricAuthState {}

class BiometricAuthSuccess extends BiometricAuthState {
  final BiometricType biometricType;

  BiometricAuthSuccess({required this.biometricType});

  @override
  List<Object> get props => [biometricType];
}

class BiometricAuthNotAvailable extends BiometricAuthState {

  BiometricAuthNotAvailable();

  @override
  List<Object> get props => [];
}
