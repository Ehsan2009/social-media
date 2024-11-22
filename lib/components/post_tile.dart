import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/models/post.dart';
import 'package:social_media/models/app_user.dart';
import 'package:social_media/screens/comments_screen.dart';
import 'package:social_media/services/user_services.dart';
import 'package:transparent_image/transparent_image.dart';

class PostTile extends StatefulWidget {
  const PostTile({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  AppUser? fetchedUser;

  @override
  void initState() {
    super.initState();
    recievedUser();
  }

  void recievedUser() async {
    fetchedUser = await UserServices().openUserProfile(widget.post.userId);
  }

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
                  context.push('/profile_screen', extra: fetchedUser);
                },
                child: Container(
                  width: 80,
                  height: 80,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(widget.post.profileUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(widget.post.name),
            ],
          ),
        ),

        // poster image
        FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image: NetworkImage(widget.post.imageUrl),
          fit: BoxFit.cover,
          height: 400,
          width: double.infinity,
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
                '${widget.post.likesCount}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    useSafeArea: true,
                    context: context,
                    builder: (ctx) {
                      return CommentsScreen(
                        post: widget.post,
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.comment,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '${widget.post.comments.length}',
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
