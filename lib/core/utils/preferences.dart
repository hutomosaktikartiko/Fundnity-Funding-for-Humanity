import 'package:shared_preferences/shared_preferences.dart';

abstract class Preferences {
  // Set Data
  set isNewUser(bool? value);
  set token(String? value);

  // Get Stored Data
  bool? get isNewUser;
  String? get token;
}

class PreferencesImpl implements Preferences {
  final SharedPreferences shared;

  PreferencesImpl({required this.shared});

  @override
  set isNewUser(bool? value) => shared.setBool("is_new_user", value!);

  @override
  set token(String? value) => shared.setString("token", value!);

  @override
  bool? get isNewUser => shared.getBool("is_new_user");

  @override
  String? get token => shared.getString("token");

  static Future<Preferences> instance() => SharedPreferences.getInstance()
      .then((value) => PreferencesImpl(shared: value));
}
