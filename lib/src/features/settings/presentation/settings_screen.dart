import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media/src/common_widgets/app_drawer.dart';
import 'package:social_media/src/features/settings/presentation/theme_mode_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeControllerProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'S E T T I N G S',
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        centerTitle: true,
      ),
      body: Card(
        elevation: 0,
        color: Theme.of(context).cardTheme.color,
        margin: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Text(
                'Dark Mode',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const Spacer(),
              themeModeAsync.when(
                data: (themeMode) {
                  final isDarkMode = themeMode == ThemeMode.dark;

                  return Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      ref
                          .read(themeModeControllerProvider.notifier)
                          .toggleThemeMode(value);
                    },
                  );
                },
                error: (error, _) => Text(error.toString()),
                loading: () => CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
