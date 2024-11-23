import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/models/post.dart';

class PostServices {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addPost(Post newPost) async {
    final postMap = newPost.toMap();

    await firebaseFirestore.collection('users').doc(uid).update(
      {
        'posts': FieldValue.arrayUnion([postMap]),
      },
    );

    await firebaseFirestore.collection('posts').add(postMap);
  }

  Future<void> like(String postId, String userId, List<String> likers) async {
    final userDoc = firebaseFirestore.collection('users').doc(userId);

    // Fetch the user's posts
    final snapshot = await userDoc.get();
    final posts =
        List<Map<String, dynamic>>.from(snapshot.data()?['posts'] ?? []);

    final postIndex = posts.indexWhere((post) => post['postId'] == postId);

    likers.add(userId);

    posts[postIndex]['likers'] = likers;

    await userDoc.update({'posts': posts});
  }

  bool isLiked(String userId, List<String> likers) {
    final isLiked = likers.contains(userId);

    return isLiked;
  }

  Future<void> unLike(String postId, String userId, List<String> likers) async {
    final userDoc = firebaseFirestore.collection('users').doc(userId);

    // Fetch the user's posts
    final snapshot = await userDoc.get();
    final posts =
        List<Map<String, dynamic>>.from(snapshot.data()?['posts'] ?? []);

    final postIndex = posts.indexWhere((post) => post['postId'] == postId);

    likers.remove(userId);

    posts[postIndex]['likers'] = likers;

    await userDoc.update({'posts': posts});
  }

  Future<void> addComment(
      String postId, String userId, String newComment) async {
    if (newComment == '') return;

    final userDoc = firebaseFirestore.collection('users').doc(userId);

    // Fetch the user's posts
    final snapshot = await userDoc.get();
    final posts =
        List<Map<String, dynamic>>.from(snapshot.data()?['posts'] ?? []);

    final postIndex = posts.indexWhere((post) => post['postId'] == postId);

    posts[postIndex]['comments'] =
        List<String>.from(posts[postIndex]['comments'] ?? [])..add(newComment);

    await userDoc.update({'posts': posts});
  }

  Future<List<Post>> allPosts() async {
    List<Post> posts = [];

    final response = await firebaseFirestore.collection('users').get();

    for (var doc in response.docs) {
      final postsList = doc.data()['posts'] as List<dynamic>?;

      if (postsList != null) {
        for (var postData in postsList) {
          posts.add(
            Post.fromMap(postData as Map<String, dynamic>),
          );
        }
      }
    }

    return posts;
  }
}
