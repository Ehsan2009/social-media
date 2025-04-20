import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media/src/features/authentication/data/auth_repository.dart';
import 'package:social_media/src/features/authentication/presentation/auth_screen.dart';
import 'package:social_media/src/features/posts/presentation/posts/posts_screen.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    
    return StreamBuilder(
      stream: authRepository.authStateChanges(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasData) {
          return const PostsScreen();
        }

        return const AuthScreen();
      },
    );
  }
}