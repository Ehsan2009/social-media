import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_media/src/features/comments/data/comments_repository.dart';

part 'comments_controller.g.dart';

@riverpod
class CommentsController extends _$CommentsController {
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> addCommentToPost(
    String postId,
    String userId,
    String newComment,
  ) async {
    final commentsRepository = ref.read(commentsRepositoryProvider);

    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      return commentsRepository.addComment(postId, userId, newComment);
    });
  }
}
