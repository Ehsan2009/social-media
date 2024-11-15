import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media/models/poster.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.poster,
  });

  final Poster poster;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          poster.name,
          style: GoogleFonts.roboto(
            fontSize: 18,
            color: Colors.grey[700],
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text('ehsanjavdan77@gmail.com'),

          const SizedBox(height: 30),

          // profile
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              poster.profileUrl,
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
                children: [Text('${poster.postsCount}'), const Text('Posts')],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  Text('${poster.followersCount}'),
                  const Text('Followers')
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  Text('${poster.followingCount}'),
                  const Text('Following')
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
