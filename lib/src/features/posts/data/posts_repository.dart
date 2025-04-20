import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_media/src/features/authentication/domain/app_user.dart';
import 'package:social_media/src/features/posts/domain/post.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'posts_repository.g.dart';

class PostsRepository {
  const PostsRepository(this._firestore, this._supabase);
  final FirebaseFirestore _firestore;
  final Supabase _supabase;

  Future<void> addPost(Post newPost, String userId) async {
    final postMap = newPost.toMap();

    await _firestore.collection('users').doc(userId).update({
      'posts': FieldValue.arrayUnion([postMap]),
    });

    await _firestore.collection('posts').add(postMap);
  }

  Future<void> like(String postId, String userId, List<String> likers) async {
    final userDoc = _firestore.collection('users').doc(userId);

    // Fetch the user's posts
    final snapshot = await userDoc.get();
    final posts = List<Map<String, dynamic>>.from(
      snapshot.data()?['posts'] ?? [],
    );

    final postIndex = posts.indexWhere((post) => post['postId'] == postId);

    likers.add(userId);

    posts[postIndex]['likers'] = likers;

    await userDoc.update({'posts': posts});
  }

  Future<void> unLike(String postId, String userId, List<String> likers) async {
    final userDoc = _firestore.collection('users').doc(userId);

    // Fetch the user's posts
    final snapshot = await userDoc.get();
    final posts = List<Map<String, dynamic>>.from(
      snapshot.data()?['posts'] ?? [],
    );

    final postIndex = posts.indexWhere((post) => post['postId'] == postId);

    likers.remove(userId);

    posts[postIndex]['likers'] = likers;

    await userDoc.update({'posts': posts});
  }

  Future<String> fetchImageUrl(File imageFile, String bucket) async {
    final supabaseClient = _supabase.client;
    final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

    await supabaseClient.storage.from(bucket).upload(fileName, imageFile);

    final imageUrl = supabaseClient.storage.from(bucket).getPublicUrl(fileName);

    return imageUrl;
  }

   Future<AppUser> postOwner(String uid) async {
    final response = await _firestore.collection('users').doc(uid).get();

    final user = AppUser.fromMap(response.data()!);

    return user;
  }
  
  Stream<List<Post>> watchPosts() {
    return _firestore
        .collection('posts')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Post.fromMap(doc.data())).toList(),
        );
  }

  Stream<Post> watchUserPost(String userId, String postId) {
    return _firestore.collection('users').doc(userId).snapshots().map((
      snapshot,
    ) {
      final data = snapshot.data();
      if (data != null) {
        final posts = List<Map<String, dynamic>>.from(data['posts']);

        final post = posts.firstWhere((post) => post['postId'] == postId);

        return Post.fromMap(post);
      } else {
        throw Exception("User post not found");
      }
    });
  }
}

@Riverpod(keepAlive: true)
PostsRepository postsRepository(Ref ref) {
  return PostsRepository(FirebaseFirestore.instance, Supabase.instance);
}

@riverpod
Stream<List<Post>> posts(Ref ref) {
  ref.keepAlive();
  final postsRepository = ref.watch(postsRepositoryProvider);
  return postsRepository.watchPosts();
}

@riverpod
Stream<Post> userPost(Ref ref, String userId, String postId) {
  final postsRepository = ref.read(postsRepositoryProvider);
  return postsRepository.watchUserPost(userId, postId);
}
