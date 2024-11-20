class Post {
  final String id;
  final String profileUrl;
  final String name;
  final String caption;
  final String imageUrl;
  final int likesCount;
  final List<String> comments;

  Post({
    required this.id,
    required this.profileUrl,
    required this.name,
    required this.caption,
    required this.imageUrl,
    required this.likesCount,
    required this.comments,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String,
      profileUrl: map['profileUrl'] as String,
      name: map['name'] as String,
      caption: map['caption'] as String,
      imageUrl: map['imageUrl'] as String,
      likesCount: map['likesCount'] as int,
      comments: List<String>.from(map['comments'] as List),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profileUrl': profileUrl,
      'name': name,
      'caption': caption,
      'imageUrl': imageUrl,
      'likesCount': likesCount,
      'comments': comments,
    };
  }
}
