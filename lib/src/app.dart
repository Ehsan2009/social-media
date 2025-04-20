import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media/src/constants/color_scheme.dart';
import 'package:social_media/src/features/settings/presentation/theme_mode_controller.dart';
import 'package:social_media/src/routing/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeControllerProvider);
    final goRouter = ref.watch(goRouterProvider);

    return themeModeAsync.when(
      data: (themeMode) {
        return MaterialApp.router(
          darkTheme: ThemeData.dark().copyWith(
            textTheme: GoogleFonts.robotoTextTheme(),
            colorScheme: kDarkColorScheme,
          ),
          theme: ThemeData().copyWith(
            textTheme: GoogleFonts.robotoTextTheme(),
            colorScheme: kColorScheme,
          ),
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          routerConfig: goRouter,
        );
      },
      error: (error, _) => Text(error.toString()),
      loading: () => CircularProgressIndicator(),
    );
  }
}
