import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/models/app_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserServices {
  final firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addUser(String name, String email, String profileUrl) async {
    final currentUid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(currentUid).set({
      'id': currentUid,
      'name': name,
      'email': email.trim(),
      'profileUrl': profileUrl,
      'postsCount': 0,
      'followersCount': 0,
      'followingCount': 0,
      'followers': [],
      'posts': [],
    });
  }

  Future<AppUser> currentUser() async {
    final currentUid = FirebaseAuth.instance.currentUser!.uid;
    final userSnapshot =
        await firebaseFirestore.collection('users').doc(currentUid).get();

    return AppUser.fromMap(userSnapshot.data()!);
  }

  Future<AppUser> openUserProfile(String uid) async {
    final response = await firebaseFirestore.collection('users').doc(uid).get();

    final user = AppUser.fromMap(response.data()!);

    return user;
  }

  Future<List<AppUser>> allUsers() async {
    List<AppUser> users = [];

    final response = await firebaseFirestore.collection('users').get();

    for (var doc in response.docs) {
      users.add(
        AppUser.fromMap(doc.data()),
      );
    }

    return users;
  }

  Future<String> getUserProfileUrl(File imageFile, String bucket) async {
    final supabase = Supabase.instance.client;
    final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';

    await supabase.storage.from(bucket).upload(fileName, imageFile);

    final imageUrl = supabase.storage.from(bucket).getPublicUrl(fileName);

    return imageUrl;
  }

  Future<void> follow(String userId, String followerId) async {
    final userDoc = firebaseFirestore.collection('users').doc(userId);

    final snapshot = await userDoc.get();

    final userData = snapshot.data();
    List<String> followers = List<String>.from(userData?['followers'] ?? []);

    followers.add(followerId);

    await userDoc.update({'followers': followers});


    // following
    final currentUid = FirebaseAuth.instance.currentUser!.uid;

    final currentUserDoc =
        firebaseFirestore.collection('users').doc(currentUid);

    await currentUserDoc.update({
      'followingCount': FieldValue.increment(1),
    });
  }

  Future<void> unfollow(String userId, String followerId) async {
    final userDoc = firebaseFirestore.collection('users').doc(userId);

    final snapshot = await userDoc.get();

    final userData = snapshot.data();
    List<String> followers = List<String>.from(userData?['followers'] ?? []);

    followers.remove(followerId);

    await userDoc.update({'followers': followers});

    // unfollowing
    final currentUid = FirebaseAuth.instance.currentUser!.uid;

    final currentUserDoc =
        firebaseFirestore.collection('users').doc(currentUid);

    await currentUserDoc.update({
      'followingCount': FieldValue.increment(-1),
    });
  }
}
