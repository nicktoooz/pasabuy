import 'package:flutter/material.dart';
import 'package:pasabuy/widgets/settingbutton.dart';
import 'package:provider/provider.dart';
import 'package:pasabuy/theme/thememanager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Column(
        children: [
          SettingButton(
            Row(
              children: [
                Text(_isDarkMode ? 'Dark Mode' : 'Light Mode'),
                const Spacer(),
                Switch(
                  value: _isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      _isDarkMode = value;
                      _updateThemePreference(value);
                      themeManager.toggleTheme(value);
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _loadThemePreference() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? savedMode = sp.getString('mode');
    setState(() {
      _isDarkMode = savedMode == 'dark';
    });
  }

  void _updateThemePreference(bool isDarkMode) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('mode', isDarkMode ? 'dark' : 'light');
  }
}
