import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media/src/features/account/data/account_repository.dart';
import 'package:social_media/src/features/account/presentation/account_controller.dart';
import 'package:social_media/src/features/posts/presentation/posts/post_tile.dart';
import 'package:social_media/src/shared/current_user_provider.dart';

class OtherUserAccountScreen extends ConsumerWidget {
  const OtherUserAccountScreen({super.key, required this.postOwnerId});

  final String postOwnerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAccountStream = ref.watch(accountStreamProvider(postOwnerId));
    final firebaseCurrentUser = ref.watch(firebaseUserProvider);

    return userAccountStream.when(
      data: (otherUserAccount) {
        final isFollowed = otherUserAccount.followers.contains(
          firebaseCurrentUser!.uid,
        );

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            title: Text(
              otherUserAccount.name,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Text(otherUserAccount.email, style: TextStyle(color: Theme.of(context).colorScheme.secondary,),),

                const SizedBox(height: 30),

                // profile
                Container(
                  width: 140,
                  height: 140,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.hardEdge,
                  child: CachedNetworkImage(
                    imageUrl: otherUserAccount.profileUrl,
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 20),

                // followers, following and posts
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${otherUserAccount.posts.length}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                         Text('Posts', style: TextStyle(color: Theme.of(context).colorScheme.secondary,),),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Column(
                      children: [
                        Text(
                          '${otherUserAccount.followers.length}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                         Text('Followers', style: TextStyle(color: Theme.of(context).colorScheme.secondary,),),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Column(
                      children: [
                        Text(
                          '${otherUserAccount.followingCount}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                         Text('Following', style: TextStyle(color: Theme.of(context).colorScheme.secondary,),),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // follow button
                GestureDetector(
                  onTap: () async {
                    if (!isFollowed) {
                      ref
                          .read(accountControllerProvider.notifier)
                          .followUser(
                            otherUserAccount.id,
                            firebaseCurrentUser.uid,
                          );
                    } else {
                      ref
                          .read(accountControllerProvider.notifier)
                          .unFollowUser(
                            otherUserAccount.id,
                            firebaseCurrentUser.uid,
                          );
                    }
                  },
                  child: Container(
                    width: 350,
                    height: 70,
                    decoration: BoxDecoration(
                      color: isFollowed ? Colors.grey[600] : Colors.blue,
                      borderRadius: BorderRadiusDirectional.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      isFollowed ? 'unfollow' : 'Follow',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // posts
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Posts', style: TextStyle(color: Theme.of(context).colorScheme.secondary,),),
                  ),
                ),

                if (otherUserAccount.posts.isNotEmpty)
                  ...otherUserAccount.posts.map((post) {
                    return PostTile(post: post);
                  })
                else
                  Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Text('This account has no post.', style: TextStyle(color: Theme.of(context).colorScheme.secondary,),),
                  ),
              ],
            ),
          ),
        );
      },
      error: (error, _) => Center(child: Text(error.toString())),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
