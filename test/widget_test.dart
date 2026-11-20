// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dlpcrt_system/app.dart';
import 'package:dlpcrt_system/core/theme/theme_provider.dart';
import 'package:dlpcrt_system/core/theme/theme_preference_service.dart';

void main() {
  testWidgets('App navigates from splash to welcome', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(966, 406);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          themePreferenceServiceProvider.overrideWithValue(
            _TestThemePreferenceService(),
          ),
        ],
        child: const App(),
      ),
    );

    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Welcome to Landbridge'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

class _TestThemePreferenceService extends ThemePreferenceService {
  @override
  Future<ThemeMode> load() async => ThemeMode.system;

  @override
  Future<void> save(ThemeMode mode) async {}
}
