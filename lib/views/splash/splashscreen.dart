import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pasabuy/main.dart';
import 'package:pasabuy/services/settings.dart';
import 'package:pasabuy/theme/theme.dart';
import 'package:pasabuy/utils/utils.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  String text = '';
  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  Future<void> _startSplashScreen() async {
    await Future.delayed(2.s);
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainApp(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = ref.watch(themeManagerProvider);
    return Scaffold(
      backgroundColor:
          themeManager == ThemeMode.dark ? darkTheme.canvasColor : lightTheme.canvasColor,
      body: Center(
        child: Text(
          "Pasabuy",
          style: TextStyle(
            fontSize: 24.sp,
            color: themeManager == ThemeMode.dark ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
