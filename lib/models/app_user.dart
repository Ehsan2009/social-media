import 'package:social_media/models/post.dart';

class AppUser {
  final String id;
  final String name;
  final String email;
  final String profileUrl;
  final int postsCount;
  final int followersCount;
  final int followingCount;
  final List<Post> posts;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.profileUrl,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
    required this.posts,
  });

  factory AppUser.fromJson(String id, Map<String, dynamic> json) {
    final fetchedPosts = (json['posts'] as List<dynamic>?)?.map((postMap) {
          if (postMap is Map<String, dynamic>) {
            return Post.fromMap(postMap);
          } else {
            return Post(
              profileUrl: '',
              name: '',
              caption: '',
              imageUrl: '',
              likesCount: 0,
              commentsCount: 0,
              comments: [],
            );
          }
        }).toList() ??
        [];

    return AppUser(
      id: id,
      name: json['name'],
      email: json['email'],
      profileUrl: json['profileUrl'],
      postsCount: json['postsCount'],
      followersCount: json['followersCount'],
      followingCount: json['followingCount'],
      posts: fetchedPosts,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'email': email.trim(),
  //     'profileUrl': profileUrl,
  //     'bio': bio,
  //     'postsCount': postsCount,
  //     'followersCount': followersCount,
  //     'followingCount': followingCount,
  //     'postUrls': postUrls,
  //   };
  // }
}
