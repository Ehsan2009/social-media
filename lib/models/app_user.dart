import 'package:social_media/models/post.dart';

class AppUser {
  final String id;
  final String name;
  final String email;
  final String profileUrl;
  final int followersCount;
  final int followingCount;
  final List<Post> posts;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.profileUrl,
    required this.followersCount,
    required this.followingCount,
    required this.posts,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    final fetchedPosts = (map['posts'] as List<dynamic>?)?.map((postMap) {
          if (postMap is Map<String, dynamic>) {
            return Post.fromMap(postMap);
          } else {
            return Post(
              postId: '',
              userId: '',
              profileUrl: '',
              name: '',
              caption: '',
              imageUrl: '',
              likers: [],
              comments: [],
            );
          }
        }).toList() ??
        [];

    return AppUser(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profileUrl: map['profileUrl'] as String,
      followersCount: map['followersCount'] as int,
      followingCount: map['followingCount'] as int,
      posts: fetchedPosts,
    );
  }
}
