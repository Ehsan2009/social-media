import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/models/app_user.dart';

class CurrentUser {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  Future<AppUser> currentUser() async {
    final userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();


    return AppUser.fromJson(userSnapshot.id, userSnapshot.data()!);
  }
}
