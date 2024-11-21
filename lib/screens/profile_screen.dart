import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media/components/post_tile.dart';
import 'package:social_media/models/app_user.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          user.name,
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
            Text(user.email),

            const SizedBox(height: 30),

            // profile
            Container(
              width: 140,
              height: 140,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.hardEdge,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(user.profileUrl),
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
                      '${user.posts.length}',
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
                      '${user.followersCount}',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Text('Followers')
                  ],
                ),
                const SizedBox(width: 30),
                Column(
                  children: [
                    Text(
                      '${user.followingCount}',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Text('Following')
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // follow button
            Container(
              width: 350,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadiusDirectional.circular(16),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Follow',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // posts
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Posts'),
              ),
            ),

            if (user.posts.isNotEmpty)
              ...user.posts.map(
                (post) {
                  return PostTile(
                    post: post,
                  );
                },
              )
            else

              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: const Text('This account has no post.'),
              ),
          ],
        ),
      ),
    );
  }
}
