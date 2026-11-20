import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/authentication/application/auth_controller.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/register_screen.dart';
import '../../features/authentication/presentation/screens/forgot_password_screen.dart';
import '../../features/onboarding/presentation/welcome_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/citizen/presentation/citizen_main_screen.dart'; // <-- Muhimu
import 'route_names.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.welcome,
        builder: (_, __) => const WelcomeScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.register,
        builder: (_, __) => const RegisterScreen(),
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        builder: (_, __) => const ForgotPasswordScreen(),
      ),
      
      // Dashboards
      GoRoute(
        path: RouteNames.citizenHome,
        builder: (_, __) => const CitizenMainScreen(), // <-- Imebadilishwa
      ),
      GoRoute(
        path: RouteNames.officerHome,
        builder: (_, __) => const Scaffold(body: Center(child: Text('Officer Dashboard (Phase 4)'))),
      ),
      GoRoute(
        path: RouteNames.adminHome,
        builder: (_, __) => const Scaffold(body: Center(child: Text('Admin Dashboard (Phase 4)'))),
      ),
    ],
    
    // Redirect Logic
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final isAuthRoute = state.matchedLocation == RouteNames.login ||
          state.matchedLocation == RouteNames.register ||
          state.matchedLocation == RouteNames.welcome ||
          state.matchedLocation == RouteNames.splash;

      if (!isLoggedIn && !isAuthRoute) {
        return RouteNames.login;
      }

      if (isLoggedIn && (state.matchedLocation == RouteNames.login || state.matchedLocation == RouteNames.register)) {
        return RouteNames.citizenHome; 
      }

      return null;
    },
  );
});