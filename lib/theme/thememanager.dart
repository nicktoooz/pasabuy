import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  ThemeManager() {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? mode = sp.getString('mode');
    if (mode != null) {
      _themeMode = mode == 'dark' ? ThemeMode.dark : ThemeMode.light;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('mode', isDark ? 'dark' : 'light');
    notifyListeners();
  }
}
