import 'package:flutter_clean_riverpod/config/routes/routes.dart';
import 'package:flutter_clean_riverpod/config/routes/transitions.dart';
import 'package:flutter_clean_riverpod/config/theme/app_styles.dart';
import 'package:flutter_clean_riverpod/features/auth/presentation/create_password_screen.dart';
import 'package:flutter_clean_riverpod/features/auth/presentation/email_confirmation_screen.dart';
import 'package:flutter_clean_riverpod/features/auth/presentation/forgot_password_screen.dart';
import 'package:flutter_clean_riverpod/features/auth/presentation/login_screen.dart';
import 'package:flutter_clean_riverpod/features/auth/presentation/register_screen.dart';
import 'package:flutter_clean_riverpod/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_clean_riverpod/features/main/presentation/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_riverpod/features/profile/presentation/profile_screen.dart';
import 'package:flutter_clean_riverpod/features/splash/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRouter {
  late final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.splash,
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: Center(
        child: Text(
          'Some Navigation error happened!!!',
          style: AppStyles().styleText_32_700(),
        ),
      ),
    ),
    routes: [
      _route(
        path: Routes.splash,
        pageBuilder: (state) => const SplashScreen(),
      ),
      _route(
        path: Routes.login,
        pageBuilder: (state) => const LoginScreen(),
      ),
      _route(
        path: Routes.forgotPassword,
        pageBuilder: (state) => const ForgotPasswordScreen(),
      ),
      _route(
        path: Routes.createPassword,
        pageBuilder: (state) => const CreatePasswordScreen(),
      ),
      _route(
        path: Routes.register,
        pageBuilder: (state) => const RegisterScreen(),
      ),
      _route(
        path: Routes.emailConfirmation,
        pageBuilder: (state) => const EmailConfirmationScreen(),
      ),
      ShellRoute(
        builder: (
          BuildContext context,
          GoRouterState state,
          Widget child,
        ) {
          return MainScreen(child: child);
        },
        routes: <RouteBase>[
          _route(
            path: Routes.home,
            pageBuilder: (state) => const HomeScreen(),
          ),
          _route(
            path: Routes.profile,
            pageBuilder: (state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );

  void popValue(BuildContext context, int value) {
    int v = 0;
    while (v < value) {
      GoRouter.of(context).pop();
      v++;
    }
  }

  GoRoute _route({
    required String path,
    required Widget Function(GoRouterState state) pageBuilder,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
    List<GoRoute> routes = const [],
  }) =>
      GoRoute(
        path: path,
        routes: routes,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            CustomTransitionPage<void>(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: pageBuilder(state),
          transitionsBuilder: transition ?? fadeTransition,
        ),
      );
}
