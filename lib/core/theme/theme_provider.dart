import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_preference_service.dart';

final themePreferenceServiceProvider =
    Provider<ThemePreferenceService>((ref) => ThemePreferenceService());

final themeModeProvider =
    StateNotifierProvider<ThemeModeController, ThemeMode>((ref) {
  final service = ref.watch(themePreferenceServiceProvider);
  return ThemeModeController(service);
});

class ThemeModeController extends StateNotifier<ThemeMode> {
  ThemeModeController(this._service) : super(ThemeMode.system) {
    _init();
  }

  final ThemePreferenceService _service;

  Future<void> _init() async {
    state = await _service.load();
  }

  Future<void> setMode(ThemeMode mode) async {
    state = mode;
    await _service.save(mode);
  }

  Future<void> toggle() async {
    // Cycle light <-> dark (system -> light on first toggle)
    final next = switch (state) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.light,
      ThemeMode.system => ThemeMode.light,
    };
    await setMode(next);
  }
}