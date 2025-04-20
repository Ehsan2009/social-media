import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comments_repository.g.dart';

class CommentsRepository {
  CommentsRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Future<void> addComment(
    String postId,
    String userId,
    String newComment,
  ) async {
    if (newComment == '') return;

    final userDoc = _firestore.collection('users').doc(userId);

    // Fetch the user's posts
    final snapshot = await userDoc.get();
    final posts = List<Map<String, dynamic>>.from(
      snapshot.data()?['posts'] ?? [],
    );

    final postIndex = posts.indexWhere((post) => post['postId'] == postId);

    posts[postIndex]['comments'] = List<String>.from(
      posts[postIndex]['comments'] ?? [],
    )..add(newComment);

    await userDoc.update({'posts': posts});
  }
}

@riverpod
CommentsRepository commentsRepository(Ref rer) {
  return CommentsRepository(FirebaseFirestore.instance);
}
