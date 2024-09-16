import 'package:flutter/material.dart';
import 'package:pasabuy/main.dart';
import 'package:pasabuy/theme/theme.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:pasabuy/theme/thememanager.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Scaffold(
      backgroundColor:
          themeManager.themeMode == ThemeMode.dark ? darkTheme.canvasColor : lightTheme.canvasColor,
      body: Center(
        child: Text(
          'Pasabuy',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: themeManager.themeMode == ThemeMode.dark ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
