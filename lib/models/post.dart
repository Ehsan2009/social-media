class Post {
  final String profileUrl;
  final String name;
  final String caption;
  final String imageUrl;
  final int likesCount;
  final int commentsCount;
  final List<String> comments;

  Post({
    required this.profileUrl,
    required this.name,
    required this.caption,
    required this.imageUrl,
    required this.likesCount,
    required this.commentsCount,
    required this.comments,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
       profileUrl: map['profileUrl'] as String, 
      name: map['name'] as String,           
      caption: map['caption'] as String,        
      imageUrl: map['imageUrl'] as String,    
      likesCount: map['likesCount'] as int,    
      commentsCount: map['commentsCount'] as int,
      comments: List<String>.from(map['comments'] as List),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profileUrl': profileUrl,
      'name': name,
      'caption': caption,
      'imageUrl': imageUrl,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'comments': comments,
    };
  }
}
