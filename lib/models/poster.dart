class Poster {
  final String name;
  final String profileUrl;
  final String bio;
  final int postsCount;
  final int followersCount;
  final int followingCount;
  final List<String> postUrls;

  Poster({
    required this.name,
    required this.profileUrl,
    required this.bio,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
    required this.postUrls,
  });
}
