import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pasabuy/services/settings.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeManagerProvider);
    final themeManager = ref.read(themeManagerProvider.notifier);
    final splashScreenMode = ref.watch(splashScreenSetting);
    final splashScreenController = ref.read(splashScreenSetting.notifier);

    final isDarkMode = themeMode == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0.2,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero))),
              onPressed: () {
                themeManager.toggleTheme(!isDarkMode);
              },
              child: Row(
                children: [
                  Text(isDarkMode ? 'Dark mode' : 'Light mode'),
                  const Spacer(),
                  Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        themeManager.toggleTheme(value);
                      })
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 0.2,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero))),
              onPressed: () {
                splashScreenController.toggleState(!splashScreenMode);
              },
              child: Row(
                children: [
                  const Text('Enable splash screen'),
                  const Spacer(),
                  Switch(
                      value: splashScreenMode,
                      onChanged: (value) {
                        splashScreenController.toggleState(value);
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
