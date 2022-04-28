import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageInfo {
  // Set Data
  Future<void> setPinVerification(String value);
  Future<void> setPasswordWallet(String value);

  // Get Stored Data
  Future<String?> getPinVerification();
  Future<String?> getPasswordWallet();
}

class SecureStorageInfoImpl implements SecureStorageInfo {
  final FlutterSecureStorage flutterSecureStorage;

  SecureStorageInfoImpl({required this.flutterSecureStorage});

  @override
  Future<void> setPinVerification(String value) async => await flutterSecureStorage.write(key: "pin_verification", value: value);

  @override
  Future<void> setPasswordWallet(String value) async => await flutterSecureStorage.write(key: "password_wallet", value: value);

  @override
  Future<String?> getPinVerification () async => await flutterSecureStorage.read(key: "pin_verification");

  @override
  Future<String?> getPasswordWallet () async => await flutterSecureStorage.read(key: "password_wallet");
}