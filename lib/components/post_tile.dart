import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/models/post.dart';
import 'package:social_media/models/app_user.dart';

class PostTile extends StatelessWidget {
  const PostTile({
    super.key,
    required this.post,
    required this.user,
  });

  final Post post;
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // poster profile and name
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.push('/profile_screen', extra: user);
                },
                child: Container(
                  width: 80,
                  height: 80,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.network(post.profileUrl, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 16),
              Text(post.name),
            ],
          ),
        ),

        // poster image
        Container(
          height: 400,
          child: Image.network(post.imageUrl, fit: BoxFit.cover,),
        ),

        // poster amount of likes and comments and duration of publication
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              const SizedBox(width: 5),
              Text(
                '${post.likesCount}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.comment,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 5),
              Text(
                '${post.likesCount}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const Spacer(),
              Text(
                '34 minutes ago',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
