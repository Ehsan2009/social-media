import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media/src/common_widgets/app_drawer.dart';
import 'package:social_media/src/features/posts/data/posts_repository.dart';
import 'package:social_media/src/features/posts/presentation/posts/post_tile.dart';
import 'package:social_media/src/features/posts/presentation/posts/shimmer_post_tile.dart';
import 'package:social_media/src/routing/app_router.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Text('HOME', style: TextStyle(letterSpacing: 4)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(AppRoute.uploadPost.name);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final postsAsync = ref.watch(postsProvider);
          return postsAsync.when(
            data: (posts) {
              if (posts.isEmpty) {
                return Center(
                  child: Text('There is no post here, try adding some!'),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  children: [for (var post in posts) PostTile(post: post)],
                ),
              );
            },
            error: (error, _) {
              return Center(child: Text(error.toString()));
            },
            loading: () {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: const Color.fromRGBO(255, 255, 255, 1),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (ctx, index) {
                    return const ShimmerPostTile();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
