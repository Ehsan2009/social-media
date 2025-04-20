import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_media/src/features/account/presentation/other_user_account_screen.dart';
import 'package:social_media/src/features/authentication/data/auth_repository.dart';
import 'package:social_media/src/features/authentication/presentation/auth_screen.dart';
import 'package:social_media/src/features/posts/presentation/posts/posts_screen.dart';
import 'package:social_media/src/features/account/presentation/account_screen.dart';
import 'package:social_media/src/features/search_users/presentation/search_screen.dart';
import 'package:social_media/src/features/settings/presentation/settings_screen.dart';
import 'package:social_media/src/routing/go_router_refresh_stream.dart';
import 'package:social_media/src/routing/not_found_screen.dart';
import 'package:social_media/src/features/posts/presentation/upload_post/upload_post_screen.dart';

part 'app_router.g.dart';

enum AppRoute {
  auth,
  posts,
  uploadPost,
  settings,
  search,
  account,
  otherUserAccount,
}

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/auth',
    redirect: (context, state) {
      final isLoggedIn = authRepository.firebaseUser != null;
      final path = state.uri.path;
      if (isLoggedIn) {
        if (path == '/auth') {
          return '/posts';
        }
      } else {
        if (path != '/auth') {
          return '/auth';
        }
      }
      return null;
    },
        refreshListenable: GoRouterRefreshStream(
      authRepository.authStateChanges(),
    ),
    routes: [
      GoRoute(
        path: '/auth',
        name: AppRoute.auth.name,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/posts',
        name: AppRoute.posts.name,
        builder: (context, state) => const PostsScreen(),
      ),
      GoRoute(
        path: '/upload-post',
        name: AppRoute.uploadPost.name,
        builder: (context, state) => const UploadPostScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: AppRoute.settings.name,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/search',
        name: AppRoute.search.name,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/account',
        name: AppRoute.account.name,
        builder: (context, state) => AccountScreen(),
      ),
      GoRoute(
        path: '/user-profile',
        name: AppRoute.otherUserAccount.name,
        builder: (context, state) {
          final postOwnerId = state.extra as String;
          return OtherUserAccountScreen(postOwnerId: postOwnerId);
        },
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
