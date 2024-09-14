import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasabuy/firebase_options.dart';
import 'package:pasabuy/views/auth/signin.dart';
import 'package:pasabuy/views/auth/signup.dart';
import 'package:pasabuy/views/home.dart';
import 'package:pasabuy/views/settings/profile.dart';
import 'package:pasabuy/views/settings/settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Home(),
      routes: [
        GoRoute(
          path: 'auth/sign-up',
          builder: (context, state) => const SignUp(),
        ),
        GoRoute(
          path: 'auth/sign-in',
          builder: (context, state) => const SignIn(),
        ),
        GoRoute(
          path: 'settings',
          builder: (context, state) => const Settings(),
          routes: [
            GoRoute(
              path: 'profile',
              builder: (context, state) => const Profile(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
