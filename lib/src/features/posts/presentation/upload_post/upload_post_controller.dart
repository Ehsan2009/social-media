import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_media/src/features/posts/application/posts_service.dart';

part 'upload_post_controller.g.dart';

@riverpod  
class UploadPostController extends _$UploadPostController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> uploadPost(File imageFile ,String caption) async {
    final postsService = ref.read(postsServiceProvider);

    state = AsyncLoading();

    state = await AsyncValue.guard(() async {
      return postsService.uploadPost(caption, imageFile);
    });
  }
}