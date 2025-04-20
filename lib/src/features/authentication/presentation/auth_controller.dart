import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_media/src/features/authentication/application/auth_service.dart';
import 'package:social_media/src/features/authentication/data/auth_repository.dart';
import 'package:social_media/src/features/authentication/presentation/auth_screen.dart';
import 'package:social_media/src/features/posts/data/posts_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> authenticate(
    String name,
    String email,
    String profileUrl,
    String password,
    EmailPasswordSignInFormType formType,
  ) async {
    final authService = ref.read(authServiceProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return authService.authenticate(
        name,
        email,
        profileUrl,
        password,
        formType,
      );
    });
  }

  Future<void> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);

    state = AsyncLoading();

    state = await AsyncValue.guard(authRepository.signOut);
  }

  Future<String> fetchImageUrl(File selectedImage) async {
    final postsRepository = ref.read(postsRepositoryProvider);

    state = AsyncLoading();

    try {
      return postsRepository.fetchImageUrl(selectedImage, 'profiles');
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return '';
    }
  }
}
