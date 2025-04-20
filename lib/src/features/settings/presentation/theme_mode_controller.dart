import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_media/src/features/settings/data/settings_repository.dart';

part 'theme_mode_controller.g.dart';

@riverpod
class ThemeModeController extends _$ThemeModeController {
  Future<ThemeMode> build() async {
    final settingsRepository = await ref.read(
      settingsRepositoryProvider.future,
    );
    final isDarkMode = settingsRepository.isDarkMode();
    final themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    return themeMode;
  }

  Future<void> toggleThemeMode(final isDarkMode) async {
    final settingsRepository = await ref.watch(
      settingsRepositoryProvider.future,
    );

    settingsRepository.switchThemeMode(isDarkMode);

    state = AsyncData(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }
}
