class Post {
  final String profileUrl;
  final String name;
  final String imageUrl;
  final int likesCount;
  final int commentsCount;
  final List<String> comments;

  Post({
    required this.profileUrl,
    required this.name,
    required this.imageUrl,
    required this.likesCount,
    required this.commentsCount,
    required this.comments,
  });
}
