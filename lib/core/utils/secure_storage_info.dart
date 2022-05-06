import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageInfo {
  Future<void> setValue({required String key, required String? value});
  Future<String?> getValue({required String key});
  Future<void> delete({required String key});
  Future<void> deleteAll();
}

class SecureStorageInfoImpl implements SecureStorageInfo {
  final FlutterSecureStorage flutterSecureStorage;

  SecureStorageInfoImpl({required this.flutterSecureStorage});

  @override
  Future<void> setValue({required String key, required String? value}) async =>
      await flutterSecureStorage.write(key: key, value: value);

  @override
  Future<String?> getValue({required String key}) async =>
      await flutterSecureStorage.read(key: key);
  @override
  Future<void> delete({required String key}) async =>
      await flutterSecureStorage.delete(key: key);

  @override
  Future<void> deleteAll() async => await flutterSecureStorage.deleteAll();
}
