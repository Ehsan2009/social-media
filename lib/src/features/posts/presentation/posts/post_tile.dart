import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/src/features/posts/data/posts_repository.dart';
import 'package:social_media/src/features/posts/domain/post.dart';
import 'package:social_media/src/features/comments/presentation/comments_screen.dart';
import 'package:social_media/src/features/posts/presentation/posts/post_tile_controller.dart';
import 'package:social_media/src/routing/app_router.dart';

class PostTile extends StatelessWidget {
  const PostTile({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // poster profile and name
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  return GestureDetector(
                    onTap: () async {
                      context.pushNamed(
                        AppRoute.otherUserAccount.name,
                        extra: post.userId,
                      );
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: post.profileUrl,
                        height: 400,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 16),
              Text(post.name),
            ],
          ),
        ),

        // poster image
        CachedNetworkImage(
          imageUrl: post.imageUrl,
          height: 400,
          width: double.infinity,
          fit: BoxFit.cover,
        ),

        // poster amount of likes and comments and duration of publication
        Consumer(
          builder: (context, ref, child) {
            final postAsync = ref.watch(
              userPostProvider(post.userId, post.postId),
            );
            return postAsync.when(
              data: (post) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (post.likers.contains(post.userId) == false) {
                            await ref
                                .read(postTileControllerProvider.notifier)
                                .likePost(
                                  post.postId,
                                  post.userId,
                                  post.likers,
                                );
                          } else {
                            await ref
                                .read(postTileControllerProvider.notifier)
                                .unLikePost(
                                  post.postId,
                                  post.userId,
                                  post.likers,
                                );
                          }
                        },
                        child:
                            post.likers.contains(post.userId) == true
                                ? const Icon(Icons.favorite, color: Colors.red)
                                : Icon(
                                  Icons.favorite_border,
                                  color: Colors.grey[600],
                                ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${post.likers.length}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            useSafeArea: true,
                            context: context,
                            builder: (ctx) {
                              return CommentsScreen(post: post);
                            },
                          );
                        },
                        child: Icon(Icons.comment, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${post.comments.length}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const Spacer(),
                      Text(
                        '34 minutes ago',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                );
              },
              error: (error, _) => Center(child: Text(error.toString())),
              loading: () => Center(child: CircularProgressIndicator()),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(post.caption),
          ),
        ),
      ],
    );
  }
}
