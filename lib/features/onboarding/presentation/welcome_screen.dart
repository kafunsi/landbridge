import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routing/route_names.dart';
import '../../../shared_widgets/app_button.dart';
import '../../../shared_widgets/app_logo.dart';
import '../../../shared_widgets/language_toggle_button.dart';
import '../../../shared_widgets/spider_web_background.dart';
import '../../../shared_widgets/theme_toggle_button.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(appStringsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface =
        isDark ? AppColors.darkOnSurface : AppColors.lightOnSurface;

    return Scaffold(
      body: SpiderWebBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSizes.lg),
                    child: Column(
                      children: [
                        const SizedBox(height: AppSizes.md),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            LanguageToggleButton(),
                            ThemeToggleButton(),
                          ],
                        ),
                        const Spacer(),
                        const AppLogo(size: 88),
                        const SizedBox(height: AppSizes.xl),
                        Text(
                          strings.welcomeTitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: AppSizes.md),
                        Text(
                          strings.welcomeSubtitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: onSurface.withValues(alpha: 0.7),
                                height: 1.5,
                              ),
                        ),
                        const Spacer(),
                        AppButton(
                          label: strings.getStarted,
                          icon: Icons.arrow_forward_rounded,
                          onPressed: () => context.push(RouteNames.login),
                        ),
                        const SizedBox(height: AppSizes.sm),
                        TextButton(
                          onPressed: () => context.push(RouteNames.register),
                          child: Text(
                            '${strings.dontHaveAccount} ${strings.createAccount}',
                          ),
                        ),
                        const SizedBox(height: AppSizes.md),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}