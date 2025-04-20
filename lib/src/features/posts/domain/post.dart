import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Post {
  final String postId;
  final String userId;
  final String profileUrl;
  final String name;
  final String caption;
  final String imageUrl;
  final List<String> likers;
  final List<String> comments;

  Post({
    String? postId,
    required this.userId,
    required this.profileUrl,
    required this.name,
    required this.caption,
    required this.imageUrl,
    required this.likers,
    required this.comments,
  }) : postId = postId ?? uuid.v4();

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map['postId'] as String,
      userId: map['userId'] as String,
      profileUrl: map['profileUrl'] as String,
      name: map['name'] as String,
      caption: map['caption'] as String,
      imageUrl: map['imageUrl'] as String,
      likers: List<String>.from(map['likers'] as List),
      comments: List<String>.from(map['comments'] as List),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'userId': userId,
      'profileUrl': profileUrl,
      'name': name,
      'caption': caption,
      'imageUrl': imageUrl,
      'likers': likers,
      'comments': comments,
    };
  }
}
