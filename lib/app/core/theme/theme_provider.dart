import 'package:flutter/material.dart';

import '../../core/theme/app_theme_mode.dart';
import '../services/local_storage/local_storage.dart';
import 'app_themes.dart';

class ThemeProvider with ChangeNotifier {
  final LocalStorage localStorage;

  AppThemeMode _themeMode = AppThemeMode.system;

  ThemeProvider(this.localStorage);

  AppThemeMode get themeMode => _themeMode;

  Future<void> loadTheme() async {
    final savedTheme = await localStorage.read('themeMode');
    if (savedTheme != null) {
      _themeMode = AppThemeMode.values.firstWhere(
        (e) => e.toString() == savedTheme,
        orElse: () => AppThemeMode.system,
      );
    }
    notifyListeners();
  }

  Future<void> setTheme(AppThemeMode themeMode) async {
    _themeMode = themeMode;
    await localStorage.save('themeMode', themeMode.toString());
    notifyListeners();
  }

  ThemeMode get themeModeForMaterial {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
      default:
        return ThemeMode.system;
    }
  }

  ThemeData get lightTheme => AppThemes.lightTheme;
  ThemeData get darkTheme => AppThemes.darkTheme;
}
