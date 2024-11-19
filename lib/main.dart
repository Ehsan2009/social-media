import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_media/config/app_router.dart';
import 'package:social_media/firebase_options.dart';
import 'package:social_media/provider/theme_provider.dart';
import 'package:social_media/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   await Supabase.initialize(
    url: Constants.supabaseUrl,
    anonKey: Constants.supabaseAnonKey,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp.router(
          darkTheme: ThemeData.dark().copyWith(
            textTheme: const TextTheme().copyWith(
                bodyMedium: GoogleFonts.roboto(color: Colors.grey[500]),
                labelMedium: GoogleFonts.roboto(color: Colors.grey[300])),
            scaffoldBackgroundColor: const Color.fromARGB(255, 49, 45, 45),
            appBarTheme: AppBarTheme.of(context).copyWith(
              backgroundColor: const Color.fromARGB(255, 49, 45, 45),
              foregroundColor: Colors.grey[500],
            ),
            cardTheme: const CardTheme().copyWith(
              color: Colors.grey[800],
            ),
          ),
          theme: ThemeData().copyWith(
            textTheme: const TextTheme().copyWith(
              bodyMedium: GoogleFonts.roboto(color: Colors.grey[600]),
              labelMedium: GoogleFonts.roboto(color: Colors.grey[600]),
            ),
            scaffoldBackgroundColor: Colors.grey[300],
            appBarTheme: AppBarTheme.of(context).copyWith(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.grey[500],
            ),
            cardTheme: const CardTheme().copyWith(
              color: Colors.white,
            ),
          ),
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      },
    );
  }
}