// TODO: Implement the language toggle button.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_strings.dart';

/// Basic language toggle (EN <-> SW). Stored in provider; consumed by screens.
class LanguageToggleButton extends ConsumerWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(appLanguageProvider);
    return TextButton(
      onPressed: () => ref.read(appLanguageProvider.notifier).toggle(),
      child: Text(lang == 'en' ? 'SW' : 'EN'),
    );
  }
}