import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesInfo {
  // Set Data
  set isNewUser(bool? value);
  set wallet(String? value);

  // Get Stored Data
  bool? get isNewUser;
  String? get wallet;
}

class PreferencesInfoImpl implements PreferencesInfo {
  final SharedPreferences shared;

  PreferencesInfoImpl({required this.shared});

  @override
  set isNewUser(bool? value) => shared.setBool("is_new_user", value!);

  @override
  set wallet(String? value) => shared.setString("wallet", value!);

  @override
  bool? get isNewUser => shared.getBool("is_new_user");

  @override
  String? get wallet => shared.getString("wallet");

  static Future<PreferencesInfo> instance() => SharedPreferences.getInstance()
      .then((value) => PreferencesInfoImpl(shared: value));
}
