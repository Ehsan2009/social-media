import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/src/features/authentication/data/auth_repository.dart';
import 'package:social_media/src/routing/app_router.dart';

class NotFoundScreen extends ConsumerWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final isLoggedIn = authRepository.firebaseUser != null;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text('404 - Page not found!'),
          ElevatedButton(
            onPressed: () {
              if (isLoggedIn) {
                context.goNamed(AppRoute.posts.name);
              } else {
                context.goNamed(AppRoute.auth.name);
              }
            },
            child: Text(isLoggedIn ? 'Go Home' : 'Login'),
          ),
        ],
      ),
    );
  }
}