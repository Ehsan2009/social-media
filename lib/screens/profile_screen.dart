import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media/components/post_tile.dart';
import 'package:social_media/models/app_user.dart';
import 'package:social_media/services/user_services.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userServices = UserServices();
    // final isFollowed =
    //     userServices.isFollowed(currentUser!.uid, user.followers);

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final docData = snapshot.data!;
        final followers = List<String>.from(docData['followers']);

        final isFollowed = followers.contains(currentUser!.uid);

        final followingCount = docData['followingCount'];

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
                          '${followers.length}',
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
                          '${followingCount}',
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
                if (user.email != currentUser.email)
                  GestureDetector(
                    onTap: () async {
                      if (!isFollowed) {
                        userServices.follow(user.id, currentUser.uid);
                      } else {
                        userServices.unfollow(user.id, currentUser.uid);
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
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                if (user.email != currentUser.email) const SizedBox(height: 20),

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
                  const Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Text('This account has no post.'),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
