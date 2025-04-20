import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_media/src/features/authentication/domain/app_user.dart';
import 'package:social_media/src/features/posts/data/posts_repository.dart';

part 'post_tile_controller.g.dart';

@riverpod
class PostTileController extends _$PostTileController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> likePost(
    String postId,
    String userId,
    List<String> likers,
  ) async {
    final postsRepository = ref.read(postsRepositoryProvider);

    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      return postsRepository.like(postId, userId, likers);
    });
  }

  Future<void> unLikePost(
    String postId,
    String userId,
    List<String> likers,
  ) async {
    final postsRepository = ref.read(postsRepositoryProvider);

    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      return postsRepository.unLike(postId, userId, likers);
    });
  }
}

@riverpod
Future<AppUser> postOwner(Ref ref, String postOwnerId) async {
  final postsRepository = ref.read(postsRepositoryProvider);
  return postsRepository.postOwner(postOwnerId);
}
