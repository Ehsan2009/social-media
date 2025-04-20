import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/src/shared/shared_preferences_provider.dart';

part 'settings_repository.g.dart';

class SettingsRepository {
  const SettingsRepository(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  static const darkModeKey = 'darkMode';

  Future<void> switchThemeMode(bool isDarkMode) async {
    await sharedPreferences.setBool(darkModeKey, isDarkMode);
  }

  bool isDarkMode() => sharedPreferences.getBool(darkModeKey) ?? false;
}

@Riverpod(keepAlive: true)
Future<SettingsRepository> settingsRepository(Ref ref) async {
  final sharedPreferences = await ref.watch(sharedPreferencesProvider.future);
  return SettingsRepository(sharedPreferences);
}
