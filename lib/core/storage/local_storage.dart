import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();

  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance {
    if (_preferences == null) {
      throw Exception(
        'LocalStorage is not initialized. Call LocalStorage.init() first.',
      );
    }

    return _preferences!;
  }

  static const String themeKey = 'theme_mode';
}
