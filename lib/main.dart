import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pasabuy/views/splash/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:pasabuy/theme/theme.dart';
import 'package:pasabuy/theme/thememanager.dart';
import 'package:pasabuy/utils/appnavigation.dart';
import 'package:pasabuy/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeManager.themeMode,
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return MaterialApp.router(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      debugShowCheckedModeBanner: false,
      routerConfig: AppNavigation.router,
    );
  }
}
