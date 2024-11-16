import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media/components/post_tile.dart';
import 'package:social_media/models/app_user.dart';

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
            color: Colors.grey[700],
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('ehsanjavdan77@gmail.com'),
        
            const SizedBox(height: 30),
        
            // profile
            Container(
              width: 140,
              height: 140,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                user.profileUrl,
                width: 300,
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
                      '${user.postsCount}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const Text('Posts'),
                  ],
                ),
                const SizedBox(width: 30),
                Column(
                  children: [
                    Text(
                      '${user.followersCount}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const Text('Followers')
                  ],
                ),
                const SizedBox(width: 30),
                Column(
                  children: [
                    Text(
                      '${user.followingCount}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
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
        
            ...user.posts.map((post) {
              return PostTile(
                post: post,
                user: user,
              );
            }),
          ],
        ),
      ),
    );
  }
}
