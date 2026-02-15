import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';
import '../features/auth/login_screen.dart';
import '../features/splash/splash_screen.dart';
import '../features/collection/collection_list_screen.dart';
import '../features/collection/car_detail_screen.dart';
import '../features/collection/add_edit_car_screen.dart';
import '../features/camera/camera_scan_screen.dart';
import '../features/search/search_screen.dart';
import '../features/settings/settings_screen.dart';
import '../widgets/app_scaffold.dart';

part 'router_provider.g.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: _RouterNotifier(ref),
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final isLoading = authState.isLoading;
      final isOnLogin = state.matchedLocation == '/login';
      final isOnSplash = state.matchedLocation == '/';

      if (isLoading && isOnSplash) return null;
      if (isLoading) return '/';

      if (!isLoggedIn && !isOnLogin) return '/login';
      if (isLoggedIn && (isOnLogin || isOnSplash)) return '/collection';

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Shell route for bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          GoRoute(
            path: '/collection',
            builder: (context, state) => const CollectionListScreen(),
            routes: [
              GoRoute(
                path: 'add',
                parentNavigatorKey: _shellNavigatorKey,
                builder: (context, state) => const AddEditCarScreen(),
              ),
              GoRoute(
                path: ':carId',
                parentNavigatorKey: _shellNavigatorKey,
                builder: (context, state) => CarDetailScreen(
                  carId: state.pathParameters['carId']!,
                ),
                routes: [
                  GoRoute(
                    path: 'edit',
                    parentNavigatorKey: _shellNavigatorKey,
                    builder: (context, state) => AddEditCarScreen(
                      carId: state.pathParameters['carId'],
                    ),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/scan',
            builder: (context, state) => const CameraScanScreen(),
          ),
          GoRoute(
            path: '/search',
            builder: (context, state) => const SearchScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
}

class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(this._ref) {
    _ref.listen(authStateProvider, (_, __) => notifyListeners());
  }

  final Ref _ref;
}
