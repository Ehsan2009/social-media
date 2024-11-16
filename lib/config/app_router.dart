import 'package:go_router/go_router.dart';
import 'package:social_media/models/app_user.dart';
import 'package:social_media/screens/auth_screen.dart';
import 'package:social_media/screens/home_screen.dart';
import 'package:social_media/screens/profile_screen.dart';
import 'package:social_media/screens/search_screen.dart';
import 'package:social_media/screens/settings_screen.dart';
import 'package:social_media/screens/splash_screen.dart';
import 'package:social_media/screens/upload_post_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/auth_screen',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/home_screen',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/upload_post_screen',
      builder: (context, state) => const UploadPostScreen(),
    ),
    GoRoute(
      path: '/settings_screen',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/search_screen',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/profile_screen',
      builder: (context, state) {
        final user = state.extra as AppUser;
        return ProfileScreen(user: user);
      },
    ),
  ],
);