// TODO: Implement the splash screen.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/routing/route_names.dart';
import '../../../shared_widgets/app_logo.dart';
import '../../../shared_widgets/spider_web_background.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    // Splash duration — gives Flutter a moment to warm up Firebase and routing.
    await Future.delayed(const Duration(milliseconds: 1600));
    if (!mounted) return;
    context.go(RouteNames.welcome);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SpiderWebBackground(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppLogo(size: 96),
              SizedBox(height: AppSizes.xl),
              SizedBox(
                width: 34,
                height: 34,
                child: CircularProgressIndicator(strokeWidth: 2.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}