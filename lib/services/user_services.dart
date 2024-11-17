import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/models/app_user.dart';

class UserServices {
  final currentUid = FirebaseAuth.instance.currentUser!.uid;
  final firebaseFirestore = FirebaseFirestore.instance;

  Future<AppUser> currentUser() async {
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
}
