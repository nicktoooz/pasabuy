import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pasabuy/models/user.dart';
import 'package:pasabuy/views/auth/signin.dart';
import 'package:pasabuy/views/auth/signup.dart';
import 'package:pasabuy/views/basket.dart';
import 'package:pasabuy/views/home/home.dart';
import 'package:pasabuy/views/home/message.dart';
import 'package:pasabuy/views/home/messages.dart';
import 'package:pasabuy/views/home/new-post.dart';
import 'package:pasabuy/views/notifications.dart';
import 'package:pasabuy/views/rootmounter.dart';
import 'package:pasabuy/views/settings/profile.dart';
import 'package:pasabuy/views/settings/settings.dart';

class AppNavigation {
  AppNavigation._();

  static final String initialRoute = User().authenticated ? '/' : '/sign-in';

  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: initialRoute,
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => RootMounter(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(navigatorKey: GlobalKey<NavigatorState>(), routes: [
            GoRoute(
              path: '/basket',
              name: 'basket',
              builder: (context, state) => Basket(key: state.pageKey),
            ),
          ]),
          StatefulShellBranch(navigatorKey: GlobalKey<NavigatorState>(), routes: [
            GoRoute(
              path: '/notifications',
              name: 'notification',
              builder: (context, state) => Notifications(key: state.pageKey),
            ),
          ]),
          StatefulShellBranch(navigatorKey: GlobalKey<NavigatorState>(), routes: [
            GoRoute(
                path: '/',
                name: 'home',
                builder: (context, state) => Home(key: state.pageKey),
                routes: [
                  GoRoute(
                      path: 'new-post',
                      name: 'new-post',
                      builder: (context, state) => const NewPostPage())
                ]),
          ]),
          StatefulShellBranch(navigatorKey: GlobalKey<NavigatorState>(), routes: [
            GoRoute(
                path: '/messages',
                name: 'messages',
                builder: (context, state) => MessageListPage(key: state.pageKey),
                routes: [
                  GoRoute(
                      path: 'm',
                      builder: (context, state) {
                        final uid = state.uri.queryParameters['uid'];
                        return MessagePage(key: state.pageKey, uid: uid!);
                      })
                ])
          ]),
          StatefulShellBranch(navigatorKey: GlobalKey<NavigatorState>(), routes: [
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (context, state) => Profile(key: state.pageKey),
              routes: [
                GoRoute(
                  path: 'settings',
                  name: 'settings',
                  builder: (context, state) => SettingsPage(key: state.pageKey),
                ),
              ],
            ),
          ]),
        ],
      ),
      GoRoute(
        path: '/sign-in',
        name: 'sign-in',
        builder: (context, state) => SignIn(key: state.pageKey),
      ),
      GoRoute(
        path: '/sign-up',
        name: 'sign-up',
        builder: (context, state) => SignUp(key: state.pageKey),
      ),
    ],
  );
}
