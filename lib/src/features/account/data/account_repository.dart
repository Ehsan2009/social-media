import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:social_media/src/features/authentication/domain/app_user.dart';

part 'account_repository.g.dart';

class AccountRepository {
  const AccountRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Future<void> addUserInfoToFirebase(
    String name,
    String email,
    String profileUrl,
    String currentUserId,
  ) async {
    await _firestore.collection('users').doc(currentUserId).set({
      'id': currentUserId,
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

  Future<void> follow(
    String profileOwnerId,
    String visitorId,
    String currentUserId,
  ) async {
    final userDoc = _firestore.collection('users').doc(profileOwnerId);

    final snapshot = await userDoc.get();

    final userData = snapshot.data();
    List<String> followers = List<String>.from(userData?['followers'] ?? []);

    followers.add(currentUserId);

    await userDoc.update({'followers': followers});

    final currentUserDoc = _firestore.collection('users').doc(currentUserId);

    await currentUserDoc.update({'followingCount': FieldValue.increment(1)});
  }

  Future<void> unFollow(
    String profileOwnerId,
    String visitorId,
    String currentUserId,
  ) async {
    final userDoc = _firestore.collection('users').doc(profileOwnerId);

    final snapshot = await userDoc.get();

    final userData = snapshot.data();
    List<String> followers = List<String>.from(userData?['followers'] ?? []);

    followers.remove(currentUserId);

    await userDoc.update({'followers': followers});

    // unfollowing
    final currentUserDoc = _firestore.collection('users').doc(currentUserId);

    await currentUserDoc.update({'followingCount': FieldValue.increment(-1)});
  }

  Future<AppUser> currentAppUser(String userId) async {
    final userSnapshot = await _firestore.collection('users').doc(userId).get();
    return AppUser.fromMap(userSnapshot.data()!);
  }

  Stream<AppUser> userAccountStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => AppUser.fromMap(snapshot.data()!));
  }
}

@Riverpod(keepAlive: true)
AccountRepository accountRepository(Ref ref) {
  return AccountRepository(FirebaseFirestore.instance);
}

@Riverpod(keepAlive: true)
Stream<AppUser> accountStream(Ref ref, String userId) {
  final accountRepository = ref.read(accountRepositoryProvider);
  return accountRepository.userAccountStream(userId);
}
