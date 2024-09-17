import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenSetting extends StateNotifier<bool> {
  SplashScreenSetting() : super(false) {
    _loadSplashScreenState();
  }
  Future<void> _loadSplashScreenState() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final bool? mode = sp.getBool('splashScreenEnabled') ?? true;
    state = mode!;
  }

  Future<void> toggleState(bool enabled) async {
    state = enabled;
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('splashScreenEnabled', enabled);
  }
}

class ThemeSettings extends StateNotifier<ThemeMode> {
  ThemeSettings() : super(ThemeMode.light) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? mode = sp.getString('mode');
    state = mode == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggleTheme(bool isDark) async {
    state = isDark ? ThemeMode.dark : ThemeMode.light;
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('mode', isDark ? 'dark' : 'light');
  }
}

final splashScreenSetting =
    StateNotifierProvider<SplashScreenSetting, bool>((ref) => SplashScreenSetting());

final themeManagerProvider = StateNotifierProvider<ThemeSettings, ThemeMode>(
  (ref) => ThemeSettings(),
);
