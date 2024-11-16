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
