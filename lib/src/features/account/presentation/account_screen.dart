import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media/src/common_widgets/app_drawer.dart';
import 'package:social_media/src/features/account/data/account_repository.dart';
import 'package:social_media/src/features/posts/presentation/posts/post_tile.dart';
import 'package:social_media/src/shared/current_user_provider.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseCurrentUser = ref.watch(firebaseUserProvider);
    final userAccountStream = ref.watch(
      accountStreamProvider(firebaseCurrentUser!.uid),
    );

    return userAccountStream.when(
      data: (account) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          drawer: AppDrawer(),
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            title: Text(
              account.name,
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Text(account.email),

                const SizedBox(height: 30),

                // profile
                Container(
                  width: 140,
                  height: 140,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.hardEdge,
                  child: CachedNetworkImage(
                        imageUrl: account.profileUrl,
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
                          '${account.posts.length}',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Text('Posts'),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Column(
                      children: [
                        Text(
                          '${account.followersCount}',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Text('Followers'),
                      ],
                    ),
                    const SizedBox(width: 30),
                    Column(
                      children: [
                        Text(
                          '${account.followingCount}',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Text('Following'),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // posts
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Posts'),
                  ),
                ),

                if (account.posts.isNotEmpty)
                  ...account.posts.map((post) {
                    return PostTile(post: post);
                  })
                else
                  const Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Text('This account has no post.'),
                  ),
              ],
            ),
          ),
        );
      },
      error: (error, _) => Text(error.toString()),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
