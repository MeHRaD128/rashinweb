import 'package:flutter/foundation.dart';

import '../storage/local_storage.dart';
import 'app_theme_mode.dart';

class ThemeController extends ChangeNotifier {
  AppThemeMode _themeMode = AppThemeMode.system;

  AppThemeMode get themeMode => _themeMode;

  Future<void> loadTheme() async {
    final value = LocalStorage.instance.getString(LocalStorage.themeKey);

    switch (value) {
      case 'light':
        _themeMode = AppThemeMode.light;
        break;

      case 'dark':
        _themeMode = AppThemeMode.dark;
        break;

      default:
        _themeMode = AppThemeMode.system;
    }

    notifyListeners();
  }

  Future<void> setTheme(AppThemeMode mode) async {
    _themeMode = mode;

    await LocalStorage.instance.setString(LocalStorage.themeKey, mode.name);

    notifyListeners();
  }
}
