import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_media/src/features/posts/data/posts_repository.dart';
import 'package:social_media/src/features/posts/domain/post.dart';
import 'package:social_media/src/shared/current_user_provider.dart';

part 'posts_service.g.dart';

class PostsService {
  const PostsService(this.ref);
  final Ref ref;

  Future<void> uploadPost(String caption, File imageFile) async {
    final postsRepository = ref.read(postsRepositoryProvider);
    final currentUser = await ref.watch(appUserProvider.future);

    final postImageUrl = await postsRepository.fetchImageUrl(
      imageFile,
      'posts',
    );

    final post = Post(
      userId: currentUser.id,
      profileUrl: currentUser.profileUrl,
      name: currentUser.name,
      caption: caption,
      imageUrl: postImageUrl,
      likers: [],
      comments: [],
    );

    postsRepository.addPost(post, currentUser.id);
  }
}

@riverpod
PostsService postsService(Ref ref) {
  return PostsService(ref);
}
