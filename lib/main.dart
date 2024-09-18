import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pasabuy/models/user.dart';
import 'package:pasabuy/services/settings.dart';
import 'package:pasabuy/theme/theme.dart';
import 'package:pasabuy/views/splash/splashscreen.dart';
import 'package:pasabuy/utils/appnavigation.dart';
import 'package:pasabuy/firebase_options.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");

  final firebaseApp = Firebase.app();
  FirebaseDatabase database = FirebaseDatabase.instanceFor(
    app: firebaseApp,
    databaseURL: dotenv.env['DATABASE_URL'],
  );
  if (!kIsWeb) database.setPersistenceEnabled(true);
  database.ref('users/${User().uid}').keepSynced(true);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showSplashScreen = ref.watch(splashScreenSetting);
    return MaterialApp(
      home: showSplashScreen ? const SplashScreen() : const MainApp(),
    );
  }
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeManager = ref.watch(themeManagerProvider);
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeManager,
          debugShowCheckedModeBanner: true,
          routerConfig: AppNavigation.router,
        );
      },
    );
  }
}
